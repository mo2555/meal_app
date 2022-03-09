import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/on_boarding_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/filters.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Widget mainWidget = (prefs.getBool('watched')??false)?TabsScreen():OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MealProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => LanguageProvider(),
        ),
      ],
      child: MyApp(mainWidget:mainWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainWidget;
  MyApp({this.mainWidget});
  @override
  Widget build(BuildContext context) {
    var th = Provider.of<ThemeProvider>(context).th;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    var primarySwatch = Provider.of<ThemeProvider>(context).primarySwatch;
    return MaterialApp(
      themeMode: th,
      theme: ThemeData(
        primarySwatch: primarySwatch,
        accentColor: accentColor,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        buttonColor: Colors.black87,
        cardColor: Colors.white,
        shadowColor: Colors.black54,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color:Colors.black54,
          ),
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      darkTheme: ThemeData(
        unselectedWidgetColor: Colors.white70,
        primarySwatch: primarySwatch,
        accentColor: accentColor,
        shadowColor: Colors.white60,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        textTheme: ThemeData.dark().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Colors.white60,
          ),
          headline6: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => mainWidget,
        TabsScreen.routeName:(context)=>TabsScreen(),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(fromBoardingScreen: false,),
        ThemeScreen.routeName : (context)=>ThemeScreen(fromBoardingScreen: false,),
      },
    );
  }
}
