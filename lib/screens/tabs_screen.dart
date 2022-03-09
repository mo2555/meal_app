import 'package:flutter/material.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/category_screen.dart';
import 'package:meal_app/screens/fav_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/my_drawer.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = 'tabsScreen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List pages ;
  @override
  initState(){
    Provider.of<MealProvider>(context,listen: false).getData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeMode();
    Provider.of<ThemeProvider>(context,listen: false).getColors();
    setState(() {
      pages = [
        {
          'page':CategoryScreen(),
          'title':'Category'
        },
        {
          'page':FavoritesScreen(),
          'title':'Favorites'
        },
      ];
    });
    super.initState();
  }
  int selectItemIndex=0;
  void selectedItem(int value) {
    setState(() {
      selectItemIndex = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isLanda = MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: isLanda?null:AppBar(
        title: Text("${pages[selectItemIndex]['title']}"),
      ),
      body:isLanda?Padding(padding: EdgeInsets.only(top: 20),child: pages[selectItemIndex]['page'],): pages[selectItemIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectItemIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: selectedItem,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.category,),title: Text("Category")),
          BottomNavigationBarItem(icon: Icon(Icons.star,),title: Text("Favorites")),
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
