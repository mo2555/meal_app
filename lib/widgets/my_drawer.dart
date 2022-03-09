import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
class MyDrawer extends StatelessWidget {
  Widget buildTile(text,icon,fun,ctx){
    return ListTile(
      onTap: fun,
      title: Text(text,style: TextStyle(
        color: Theme.of(ctx).textTheme.bodyText1.color,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),),
      leading: Icon(icon,color: Theme.of(ctx).buttonColor,),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 120,
            color: Theme.of(context).accentColor,
            child: Text("Cooking Up!",style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Theme.of(context).primaryColor,
            ),),
          ),
          SizedBox(height: 20,),
          buildTile("Meal", Icons.restaurant, (){Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);},context),
          buildTile("Filters", Icons.settings, (){Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);},context),
          buildTile("Themes", Icons.color_lens_outlined, (){Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);},context),
          Divider(
            color: Theme.of(context).textTheme.headline6.color,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text("Choose your preferred language.",
            style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Arabic",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Switch(
                  value: Provider.of<LanguageProvider>(context).isEn,
                  onChanged: (value)=>
                    Provider.of<LanguageProvider>(context,listen: false).changeLan(value),
                ),
                Text("English",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Theme.of(context).textTheme.headline6.color,
          ),
        ],
      ),
    ),
    );
  }
}
