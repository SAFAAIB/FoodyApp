import 'package:flutter/material.dart';
import 'package:foody_app/data/db-helper.dart';

class Recipe {
  int id;
  String title;
  String description;
  String image;
  int calories;
  int carbo;
  int protein;
  String ingredients;
  String preparation;
  bool isFavorie;

  Recipe({

    this.title,
    this.description,
    this.image,
    this.calories,
    this.carbo,
    this.protein,
    this.ingredients,
    this.preparation,
    this.isFavorie = false,
  });

  toMap(){
    return {
      DBHelper.columnTitle : this.title,
      DBHelper.columnDescription : this.description,
      DBHelper.columnImage : this.image ,
      DBHelper.columnCalories : this.calories,
      DBHelper.columnCarbo : this.carbo,
      DBHelper.columnProtein : this.protein,
      DBHelper.columnIngredients : this.ingredients,
      DBHelper.columnPreparation : this.preparation,
      DBHelper.columnIsFavorite : this.isFavorie ? 1 : 0 ,


    };
  }

  Recipe.fromMap(Map map){
    this.id = map[DBHelper.columnId];
    this.title = map[DBHelper.columnTitle];
    this.description = map[DBHelper.columnDescription];
    this.image = map[DBHelper.columnImage];
    this.calories = map[DBHelper.columnCalories];
    this.carbo = map[DBHelper.columnCarbo];
    this.protein = map[DBHelper.columnProtein];
    this.ingredients = map[DBHelper.columnIngredients];
    this.preparation = map[DBHelper.columnPreparation];
    this.isFavorie = map[DBHelper.columnIsFavorite] == 1 ? true : false;

  }

}


