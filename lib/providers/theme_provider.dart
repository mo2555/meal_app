import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  var primarySwatch = Colors.pink;
  var accentColor = Colors.amber;
  var th = ThemeMode.system;
  var textTheme = 's';

  changeThemeMode(newTheme)async{
    th = newTheme;
    changeTextTheme(th);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('textTheme', textTheme);
  }

  changeColors(String colorName,colorHashcode)async{
    colorName=='p'?
        primarySwatch = changeMaterialColor(colorHashcode):
        accentColor = changeMaterialColor(colorHashcode);
        notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('primarySwatch', primarySwatch.value);
    prefs.setInt('accentColor', accentColor.value);
  }

  changeMaterialColor(newColor){
    return MaterialColor(
      newColor,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(newColor),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  changeTextTheme(ThemeMode th){
    if(th==ThemeMode.system)
      textTheme = 's';
    else if(th==ThemeMode.dark)
      textTheme = 'd';
    else
      textTheme = 'l';
  }

  getThemeMode()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    textTheme = prefs.getString('textTheme');
    if(textTheme == 's')
      th=ThemeMode.system;
    else if(textTheme == 'd')
    th=ThemeMode.dark;
    else
      th=ThemeMode.light;
    notifyListeners();

  }

  getColors()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primarySwatch = changeMaterialColor(prefs.getInt('primarySwatch')??0xFFE91E63);
    accentColor = changeMaterialColor(prefs.getInt('accentColor')??0xFFFFC107);
    notifyListeners();
  }

}