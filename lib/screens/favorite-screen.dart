import 'package:flutter/cupertino.dart';
import 'package:foody_app/data/recipe.dart';
import 'package:foody_app/utils/size_config.dart';
import 'package:foody_app/widgets/my-container.dart';
import 'package:foody_app/widgets/texts.dart';

class FavoriteScreen extends StatelessWidget {
  List<Recipe> allRecipes;
  Function favorite;


  FavoriteScreen(this.allRecipes, this.favorite);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: ListView.builder(
        itemCount: allRecipes
            .where((element) => element.isFavorie)
            .length,
        itemBuilder: (context, index) {
          return MyContainer(
              onPressed: favorite,
              recipe: allRecipes.where((element) => element.isFavorie)
                  .toList()[index],
              index: index,
          );
        },
      ),
    );
  }
}
