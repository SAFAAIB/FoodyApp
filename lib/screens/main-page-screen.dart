import 'package:flutter/material.dart';
import 'package:foody_app/data/recipe.dart';
import 'package:foody_app/utils/size_config.dart';
import 'package:foody_app/widgets/my-container.dart';
import 'package:foody_app/widgets/texts.dart';

class MainPageScreen extends StatelessWidget {
  List<Recipe> allRecipes;
  Function selected;
  Function favorite;

  MainPageScreen(this.allRecipes,this.selected,this.favorite);
  // void toggleFavorite(String recipeId){
  //   final existingIndex = favoriteRecipes.indexWhere((element) => element.title == recipeId);
  //
  //   if (existingIndex >= 0){
  //     setState(() {
  //       favoriteRecipes.removeAt(existingIndex);
  //     });
  //   }
  //   else{
  //     setState(() {
  //       favoriteRecipes.add(allRecipes.firstWhere((element) => element.title == recipeId));
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: SizeConfig.scaleWidth(16),
              end: SizeConfig.scaleWidth(16),
              top: SizeConfig.scaleHeight(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textTitle('Spring Salads'),
                textSubTitle('Healthy and natural food recipes', 1),
                SizedBox(
                  height: SizeConfig.scaleHeight(32),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selected('Vegetable', 'images/salad.png', 0),
                    SizedBox(
                      width: 8,
                    ),
                    selected('Rice', 'images/rice.png', 1),
                    SizedBox(
                      width: 8,
                    ),
                    selected('Fruit', 'images/fruit.png', 2),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(24),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.scaleHeight(350),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MyContainer(
                  recipe: allRecipes[index],
                  onPressed: favorite,
                  index: index,
                );
              },
              itemCount: allRecipes.length,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: SizeConfig.scaleWidth(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.scaleHeight(10),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Popular  ',
                    style: TextStyle(
                      fontSize: SizeConfig.scaleTextFont(24),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: 'Food',
                        style: TextStyle(
                          fontSize: SizeConfig.scaleTextFont(24),
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
