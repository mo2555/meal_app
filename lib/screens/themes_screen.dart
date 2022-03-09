import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = 'themeMode';
  bool fromBoardingScreen = false;
  ThemeScreen({this.fromBoardingScreen});

  Widget buildRadioTile(BuildContext context, value, icon, title) {
    return RadioListTile(
      activeColor: Theme.of(context).accentColor,
      value: value,
      groupValue: Provider.of<ThemeProvider>(context).th,
      onChanged: (newVal) => Provider.of<ThemeProvider>(context, listen: false)
          .changeThemeMode(newVal),
      title: Text(
        title,
        style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
      ),
      secondary: icon,
    );
  }

  Widget buildListTile(String title, BuildContext context, String color) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: color == 'p'
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor,
      ),
      onTap: () {
        return showDialog(
            context: context,
            builder: (cyx) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: color == 'p'
                        ? Provider.of<ThemeProvider>(context).primarySwatch
                        : Provider.of<ThemeProvider>(context).accentColor,
                    onColorChanged: (newColor) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeColors(color, newColor.hashCode),
                    colorPickerWidth: 300.0,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    showLabel: false,
                  ),
                ),
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            title: fromBoardingScreen?null:Text("Your Themes"),
            backgroundColor: fromBoardingScreen?Theme.of(context).canvasColor:Theme.of(context).primaryColor,
            elevation: fromBoardingScreen?0:5,
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              alignment: Alignment.center,
              child: Text(
                "Adjust your themes selection",
                style: Theme.of(context).textTheme.headline6,
              ),
              margin: EdgeInsets.all(15),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Choose your Theme Mode",
                style: Theme.of(context).textTheme.headline6,
              ),
              margin: EdgeInsets.all(15),
            ),
            buildRadioTile(
                context, ThemeMode.system, null, 'System Default Theme'),
            buildRadioTile(
                context,
                ThemeMode.light,
                Icon(
                  Icons.wb_sunny_outlined,
                  color: Theme.of(context).buttonColor,
                ),
                'Light Theme'),
            buildRadioTile(
                context,
                ThemeMode.dark,
                Icon(Icons.nights_stay_outlined,
                    color: Theme.of(context).buttonColor),
                'Dark Theme'),
            buildListTile('Choose your primary color', context, 'p'),
            buildListTile('Choose your accent color', context, 'a'),
            SizedBox(
              height: fromBoardingScreen?100:0,
            ),
          ]))
        ],
      ),
      drawer: fromBoardingScreen?null:MyDrawer(),
    );
  }
}
/*appBar: fromBoardingScreen?AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ):AppBar(
        title: Text("Your Themes"),
      ),*/