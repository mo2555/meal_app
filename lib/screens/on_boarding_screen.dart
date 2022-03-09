import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    bool isLanda = MediaQuery.of(context).orientation == Orientation.landscape;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index){
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage(
                      'assets/images/image.jpg',
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width:double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      color: Colors.black45,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Cooking Up!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        color: Colors.black54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Choose your language",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Arabic",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold
                                    ),
                                ),
                                Switch(
                                  value:
                                      Provider.of<LanguageProvider>(context)
                                          .isEn,
                                  onChanged: (value) =>
                                      Provider.of<LanguageProvider>(context,
                                              listen: false)
                                          .changeLan(value),
                                ),
                                Text(
                                  "English",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              ThemeScreen(fromBoardingScreen:true,),
              FilterScreen(fromBoardingScreen:true),
            ],
          ),
          Builder(
            builder: (ctx)=> Container(
              alignment: Alignment(0, 0.8),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal:
                isLanda?(width*0.6/2):80),
                onPressed: () async{
                  Navigator.of(ctx).pushReplacementNamed(TabsScreen.routeName);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool('watched', true);
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  "GET STARTED",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
