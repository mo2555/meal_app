import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreen extends StatefulWidget {
  static String routeName = 'category_meal';

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String routeTitle;
  List<Meal> categoryMeal;
  @override
  void didChangeDependencies() {
    final List availableMeals = Provider.of<MealProvider>(context).availableMeals;
    final routeArg = ModalRoute.of(context).settings.arguments as Map;
    final routeID = routeArg['id'];
    routeTitle = routeArg['title'];
    categoryMeal = availableMeals.where((meal){
      return meal.categories.contains(routeID);
    }).toList();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
  bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
  var width = MediaQuery.of(context).size.width;
    return Scaffold(
    appBar: AppBar(
      title: Text(routeTitle),
    ),
      body: isLandscape?GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width*0.5,
            childAspectRatio: 2.9/2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        itemCount: categoryMeal.length,
          itemBuilder: (ctx,index){
          return MealItem(
            title: categoryMeal[index].title,
            imageUrl: categoryMeal[index].imageUrl,
            duration: categoryMeal[index].duration,
            complexity: categoryMeal[index].complexity,
            affordability: categoryMeal[index].affordability,
            id: categoryMeal[index].id,
          );
          }
      ):ListView.builder(
          itemCount: categoryMeal.length,
          itemBuilder: (ctx,index){
            return MealItem(
              title: categoryMeal[index].title,
              imageUrl: categoryMeal[index].imageUrl,
              duration: categoryMeal[index].duration,
              complexity: categoryMeal[index].complexity,
              affordability: categoryMeal[index].affordability,
              id: categoryMeal[index].id,
            );
          }
      ),
    );
  }

}
