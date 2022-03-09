import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = 'meal_detail';

  Widget buildTitle(String text, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: 300,
      height: 200,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var accentColor = Theme.of(context).accentColor;
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectMeal.title),
              background: Hero(
                tag: mealID,
                child: InteractiveViewer(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/a2.png'),
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      selectMeal.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        buildTitle("Ingredients", context),
                        buildContainer(
                          ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: selectMeal.ingredients.length,
                              itemBuilder: (ctx, index) {
                                return Card(
                                  color: accentColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Text(
                                      "${selectMeal.ingredients[index]}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        buildTitle("Steps", context),
                        buildContainer(
                          ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: selectMeal.steps.length,
                              itemBuilder: (ctx, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        child: Text("# ${index + 1}"),
                                      ),
                                      title: Text(
                                        "${selectMeal.steps[index]}",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              if (!isLandscape) buildTitle("Ingredients", context),
              if (!isLandscape)
                buildContainer(
                  ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: selectMeal.ingredients.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: accentColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
                              "${selectMeal.ingredients[index]}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }),
                ),
              if (!isLandscape) buildTitle("Steps", context),
              if (!isLandscape)
                buildContainer(
                  ListView.builder(
                      padding: EdgeInsets.all(10),
                      itemCount: selectMeal.steps.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                child: Text("# ${index + 1}"),
                              ),
                              title: Text(
                                "${selectMeal.steps[index]}",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Divider()
                          ],
                        );
                      }),
                ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Provider.of<MealProvider>(context).isFavorite(mealID)
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
        onPressed: () {
          Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealID);
        },
      ),
    );
  }
}
