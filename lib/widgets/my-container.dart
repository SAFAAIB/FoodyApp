import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/data/recipe.dart';
import 'package:foody_app/screens/details-screen.dart';
import 'package:foody_app/utils/app_colors.dart';
import 'package:foody_app/utils/size_config.dart';

class MyContainer extends StatelessWidget {
  Recipe recipe;
  Function onPressed;
  int index;

  MyContainer({this.recipe, this.onPressed, this.index});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(recipe: recipe, favorite: onPressed,),
          ),
        );
      },
      child: Container(
        width: SizeConfig.scaleWidth(220),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsetsDirectional.only(
            start: index == 0
                ? SizeConfig.scaleWidth(16)
                : SizeConfig.scaleWidth(0),
            top: SizeConfig.scaleHeight(8),
            bottom: SizeConfig.scaleHeight(16),
            end: SizeConfig.scaleWidth(16)),
        padding: EdgeInsetsDirectional.only(
          top: SizeConfig.scaleHeight(16),
          bottom: SizeConfig.scaleHeight(16),
          start: SizeConfig.scaleWidth(16),
          end: SizeConfig.scaleWidth(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              child: Image.asset(
                recipe.image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(8),
            ),
            Text(
              recipe.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(22),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(8),
            ),
            Text(
              recipe.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: SizeConfig.scaleTextFont(16),
                color: Colors.grey[400],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recipe.calories.toString() + ' Kcal',
                  style: TextStyle(
                    fontSize: SizeConfig.scaleTextFont(16),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: recipe.isFavorie
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: onPressed(recipe),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
