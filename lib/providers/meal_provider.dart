
import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  List<String> prefsMealId = [];

  List<Category> availableCategory = [];

  void setFilters() async {
    availableMeals = DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (filters['vegan'] && !meal.isVegan) {
        return false;
      }
      if (filters['vegetarian'] && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if (cat.id == catId) {
            if (!ac.any((cat) => cat.id == catId)) ac.add(cat);
          }
        });
      });
    });
    availableCategory = ac;

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("gluten", filters['gluten']);
    prefs.setBool("lactose", filters['lactose']);
    prefs.setBool("vegan", filters['vegan']);
    prefs.setBool("vegetarian", filters['vegetarian']);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    filters['gluten'] = prefs.getBool("gluten") ?? false;
    filters['lactose'] = prefs.getBool("lactose") ?? false;
    filters['vegan'] = prefs.getBool("vegan") ?? false;
    filters['vegetarian'] = prefs.getBool("vegetarian") ?? false;
    setFilters();

    prefsMealId = prefs.getStringList("prefsMealId") ?? [];
    for (var mealId in prefsMealId) {
      final existingIndex =
      favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    }

    List<Meal> fm = [];
    favoriteMeals.forEach((favMeals) {
      availableMeals.forEach((avMeals) {
        if(favMeals.id == avMeals.id) fm.add(favMeals);
      });
    });
    favoriteMeals = fm;

    notifyListeners();
  }

  void toggleFavorite(String mealId) async {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      favoriteMeals.removeAt(existingIndex);
      prefsMealId.remove(mealId);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      prefsMealId.add(mealId);
    }

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("prefsMealId", prefsMealId);
  }

  bool isFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.id == mealId);
  }
}

/*
import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/dummy_data.dart';
class MealProvider with ChangeNotifier{
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<String> favoriteMealsId =[];
  List<Category> availableCategory = DUMMY_CATEGORIES;
  List<String> availableCategoryId = [];

  getData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    filters['gluten'] = sharedPreferences.getBool('gluten') ?? false;
    filters['lactose'] = sharedPreferences.getBool('lactose') ?? false;
    filters['vegan'] = sharedPreferences.getBool('vegan') ?? false;
    filters['vegetarian'] = sharedPreferences.getBool('vegetarian') ?? false;
    favoriteMealsId = sharedPreferences.getStringList('favoriteMealsId') ?? [];
    availableCategoryId = sharedPreferences.getStringList('availableCategoryId')??[];
    for (var i in favoriteMealsId) {
      final selectIndex = favoriteMeals.indexWhere((meal) => meal.id == i);
      if (selectIndex < 0) {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == i));
      }
    }
    for (var i in availableCategoryId) {
      final selectIndex = availableCategory.indexWhere((cat) => cat.id == i);
      if (selectIndex < 0) {
        availableCategory.add(DUMMY_CATEGORIES.firstWhere((cat) => cat.id == i));
      }
    }
    notifyListeners();
  }

  void setFilters() async {
    availableMeals = (DUMMY_MEALS.where((meal) {
      if (filters['gluten'] && meal.isGlutenFree == false) {
        return false;
      }

      if (filters['lactose'] && meal.isLactoseFree == false) {
        return false;
      }

      if (filters['vegan'] && meal.isVegan == false) {
        return false;
      }

      if (filters['vegetarian'] && meal.isVegetarian == false) {
        return false;
      }
      return true;
    })).toList();
    List<Category> ac = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(catId == cat.id){
            if(!ac.any((element) => element.id == catId)) {
              availableCategoryId.add(catId);
              ac.add(cat);
            }
          }
        });
      });
    });
  availableCategory = ac;
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('gluten', filters['gluten']);
    sharedPreferences.setBool('lactose', filters['lactose']);
    sharedPreferences.setBool('vegan', filters['vegan']);
    sharedPreferences.setBool('vegetarian', filters['vegetarian']);
    sharedPreferences.setStringList('availableCategoryId', availableCategoryId);
  }
  void selectFavorite(String mealID) async{
    final selectIndex = favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (selectIndex >= 0) {
      favoriteMeals.removeAt(selectIndex);
      favoriteMealsId.remove(mealID);
    } else {
      favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      if(!favoriteMealsId.contains(mealID))
      favoriteMealsId.add(mealID);
    }
    notifyListeners();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList('favoriteMealsId', favoriteMealsId);
  }

  bool isMealFav(mealID){
    return favoriteMeals.any((meal) => meal.id == mealID);
  }

}*/
