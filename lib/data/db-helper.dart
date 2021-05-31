import 'dart:io';
import 'package:foody_app/data/recipe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database dataBase;
  static final String tableRecipe = 'recipe';
  static final String columnId = '_vid';
  static final String columnTitle = 'title';
  static final String columnDescription = 'description';
  static final String columnImage = 'image';
  static final String columnCalories = 'calory';
  static final String columnCarbo = 'carbo';
  static final String columnProtein = 'protein';
  static final String columnIngredients = 'ingredients';
  static final String columnPreparation = 'preparation';
  static final String columnIsFavorite = 'isFavorite';

  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  Future<Database> initDatabase() async {
    if (dataBase == null) {
      dataBase = await createConnectionWithDatabase();
      return dataBase;
    } else
      return dataBase;
  }

  Future<Database> createConnectionWithDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String databaseName = 'recipes.db';
    String dpPath = appDocPath + '/$databaseName';
    Database dataBase = await openDatabase(
      dpPath,
      version: 2,
      onCreate: (dataBase, v) async {
        await dataBase.execute('''CREATE TABLE $tableRecipe ( 
  $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
  $columnTitle TEXT ,
  $columnDescription TEXT,
  $columnImage TEXT,
  $columnCalories INTEGER,
  $columnCarbo INTEGER,
  $columnProtein INTEGER, 
  $columnIngredients TEXT,
  $columnPreparation TEXT,
  $columnIsFavorite INTEGER )
        ''');
      },
    );
    return dataBase;
  }

  insertRecipe(Recipe recipe) async {
    Database database = await initDatabase();
    await database.insert(tableRecipe, recipe.toMap());
  }

  Future<List<Recipe>> getAllRecipes() async {
    Database database = await initDatabase();
    List<Map<String, Object>> rows = await database.query(tableRecipe);
    List<Recipe> recipes = rows.map((e) => Recipe.fromMap(e)).toList();
    return recipes;
  }

  Future<List<Recipe>> getOneRecipes(int id) async {
    Database database = await initDatabase();
    List<Map<String, Object>> rows = await database.query(
      tableRecipe,
      where: '$columnId=?',
      whereArgs: [id],
    );
    List<Recipe> tasks = rows.map((e) => Recipe.fromMap(e)).toList();
    return tasks;
  }

  deleteRecipe() async {
    Database database = await initDatabase();
    return await database.delete(
      tableRecipe,
      // where: '$columnId=?',
      // whereArgs: [id],
    );

  }

  upDateRecipe(Recipe recipe) async {
    Database database = await initDatabase();
    recipe.isFavorie = !recipe.isFavorie;
    return await database.update(
      tableRecipe,
      recipe.toMap(),
      where: '$columnId=?',
      whereArgs: [recipe.id],
    );
  }
}