import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    @required this.imageUrl,
    @required this.title,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.id,
  });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple : return 'Simple' ; break;
      case Complexity.Challenging : return 'Challenging' ; break;
      case Complexity.Hard : return 'Hard' ; break;
      default :
        return 'UnKnow';
    }
  }

  String get affordabilityText{
    switch(affordability){
      case Affordability.Affordable : return 'Affordable' ; break;
      case Affordability.Luxurious : return 'Luxurious' ; break;
      case Affordability.Pricey : return 'Pricey' ; break;
      default :
        return 'UnKnow';
    }
  }

  void selectItem(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        MealDetailScreen.routeName,
    arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>selectItem(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: id,
                    child: InteractiveViewer(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        height: 200,
                        image: NetworkImage(
                          imageUrl,
                        ),
                        width: double.infinity,
                        placeholder: AssetImage(
                            'assets/images/a2.png'
                        ),
                      )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    color: Colors.black26,
                    child: Text(title,style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.alarm,color: Theme.of(context).buttonColor,),
                      SizedBox(width: 6,),
                      Text("$duration min"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work,color: Theme.of(context).buttonColor,),
                      SizedBox(width: 6,),
                      Text("$complexityText"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money,color: Theme.of(context).buttonColor,),
                      SizedBox(width: 6,),
                      Text("$affordabilityText"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
