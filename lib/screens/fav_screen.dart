import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    final List favoriteMeals = Provider.of<MealProvider>(context).favoriteMeals;
    if(favoriteMeals.isEmpty){
      return Center(
        child: Text("You have to add fav meal."),
      );
    }
    else{
      return isLandscape?GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: width*0.5,
            childAspectRatio: 2.9/2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          itemCount: favoriteMeals.length,
          itemBuilder: (ctx,index){
            return MealItem(
              title: favoriteMeals[index].title,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              id: favoriteMeals[index].id,
            );
          }
      ):ListView.builder(
          itemCount: favoriteMeals.length,
          itemBuilder: (ctx,index){
            return MealItem(
              title: favoriteMeals[index].title,
              imageUrl: favoriteMeals[index].imageUrl,
              duration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              id: favoriteMeals[index].id,
            );
          }
      );
    }
  }
}
