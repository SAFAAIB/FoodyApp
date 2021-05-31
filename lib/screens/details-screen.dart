import 'package:flutter/material.dart';
import 'package:foody_app/data/recipe.dart';
import 'package:foody_app/utils/app_colors.dart';
import 'package:foody_app/utils/size_config.dart';
import 'package:foody_app/widgets/texts.dart';

class DetailsScreen extends StatelessWidget {
  final Recipe recipe;
  Function favorite;

  DetailsScreen({@required this.recipe,this.favorite});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: favorite(recipe),
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig.scaleWidth(16),
            top: SizeConfig.scaleHeight(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textTitle(recipe.title),
              textSubTitle(recipe.description , 1),
              Container(
                height: SizeConfig.scaleHeight(310),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textTitle2('Nutritions', Colors.black),
                        SizedBox(
                          height: SizeConfig.scaleHeight(16),
                        ),
                        buildNutrition(recipe.calories, "Calories", "Kcal"),
                        SizedBox(
                          height: SizeConfig.scaleHeight(16),
                        ),
                        buildNutrition(recipe.carbo, "Carbo", "g"),
                        SizedBox(
                          height: SizeConfig.scaleHeight(16),
                        ),
                        buildNutrition(recipe.protein, "Protein", "g"),
                      ],
                    ),
                    PositionedDirectional(
                      end: SizeConfig.scaleWidth(-110),
                      child: Container(
                        height: SizeConfig.scaleHeight(310),
                        width: SizeConfig.scaleWidth(310),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(recipe.image),
                            fit: BoxFit.fitHeight,
                          ),
                        ),

                      ),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  end: SizeConfig.scaleHeight(16)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textTitle2('Ingredients', Colors.black),
                    textSubTitle(recipe.ingredients , 1.8),
                    textTitle2('Recipe preparation', Colors.black),
                    textSubTitle(recipe.preparation , 1.8),
                  ],
                ),
              )







            ],
          ),
        ),
      ),
    );
  }

  Widget buildNutrition(int value, String title, String subTitle) {
    return Container(
      height: SizeConfig.scaleHeight(60),
      width: SizeConfig.scaleWidth(150),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(8),
        vertical: SizeConfig.scaleHeight(8),
      ),
      margin: EdgeInsetsDirectional.only(
        start: SizeConfig.scaleWidth(4),
      ),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(50),
        boxShadow: [AppColors.boxShadow],
      ),
      child: Row(
        children: [
          Container(
            height: SizeConfig.scaleHeight(44),
            width: SizeConfig.scaleWidth(44),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [AppColors.boxShadow],
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.scaleWidth(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: SizeConfig.scaleTextFont(12),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
