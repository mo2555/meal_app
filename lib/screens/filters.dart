import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  static final routeName = 'filter';
  var fromBoardingScreen = false;

  FilterScreen({this.fromBoardingScreen});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Widget buildSwitchListTile(
      String title, String subTitle, bool value, Function changed) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: changed,
      inactiveTrackColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map filters = Provider.of<MealProvider>(context).filters;
    return Scaffold(
      drawer: widget.fromBoardingScreen ? null : MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            elevation: widget.fromBoardingScreen ? 0 : 5,
            title: widget.fromBoardingScreen ? null : Text("Filters"),
            backgroundColor: widget.fromBoardingScreen
                ? Theme.of(context).canvasColor
                : Theme.of(context).primaryColor,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Adjust your meal selection.",
                  style: Theme.of(context).textTheme.headline6,
                ),
                padding: EdgeInsets.all(20),
              ),
              buildSwitchListTile(
                "Gluten-Free",
                "Only include Gluten-Free meals.",
                filters['gluten'],
                    (newValue) {
                  setState(() {
                    filters['gluten'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              buildSwitchListTile(
                "Lactose-Free",
                "Only include Lactose-Free meals.",
                filters['lactose'],
                    (newValue) {
                  setState(() {
                    filters['lactose'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              buildSwitchListTile(
                "Vegan-Free",
                "Only include Vegan-Free meals.",
                filters['vegan'],
                    (newValue) {
                  setState(() {
                    filters['vegan'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),
              buildSwitchListTile(
                "Vegetarian-Free",
                "Only include Vegetarian-Free meals.",
                filters['vegetarian'],
                    (newValue) {
                  setState(() {
                    filters['vegetarian'] = newValue;
                  });
                  Provider.of<MealProvider>(context, listen: false)
                      .setFilters();
                },
              ),

              SizedBox(
                height: widget.fromBoardingScreen ? 100 : 0,
              ),
            ]),
          ),
        ],

      ),
    );
  }
}
