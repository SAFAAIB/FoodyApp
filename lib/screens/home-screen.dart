import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foody_app/data/db-helper.dart';
import 'package:foody_app/data/recipe.dart';
import 'package:foody_app/screens/add-recipe-screen.dart';
import 'package:foody_app/screens/favorite-screen.dart';
import 'package:foody_app/screens/main-page-screen.dart';
import 'package:foody_app/utils/app_colors.dart';
import 'package:foody_app/utils/size_config.dart';
import 'package:foody_app/widgets/my-container.dart';
import 'package:foody_app/widgets/texts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  List<bool> selectedIndex = [true, false, false];
  List<Recipe> allRecipes;
  List<Recipe> favoriteRecipes ;
  List<String> titles = ['Foody App' , 'Add new Recipe' , 'Favorites'];

  int index = 0;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    getAllFunction();
  }

  getAllFunction() async {
    List<Recipe> recipes = await DBHelper.dbHelper.getAllRecipes();
    this.allRecipes = recipes;
    setState(() {});
  }

  addFunc(Recipe recipe) async {
    await DBHelper.dbHelper.insertRecipe(recipe);
    await getAllFunction();
  }

  deleteFunction() async {
    await DBHelper.dbHelper.deleteRecipe();
    await getAllFunction();
  }

  editFunction(Recipe recipe) async {
    await DBHelper.dbHelper.upDateRecipe(recipe);
    await getAllFunction();
  }

  Widget selected(String name, String path, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex[index] = !selectedIndex[index];
        });
      },
      child: Container(
        height: SizeConfig.scaleHeight(40),
        decoration: BoxDecoration(
          color: selectedIndex[index] ? AppColors.MAIN_COLOR : Colors.white,
          boxShadow: [AppColors.boxShadow],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: SizeConfig.scaleWidth(12),
            end: SizeConfig.scaleWidth(12),
          ),
          child: Row(
            children: [
              SizedBox(
                height: SizeConfig.scaleHeight(32),
                width: SizeConfig.scaleWidth(32),
                child: Image.asset(
                  path,
                  color: selectedIndex[index] ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(
                width: SizeConfig.scaleWidth(8),
              ),
              Text(
                name,
                style: TextStyle(
                  color: selectedIndex[index] ? Colors.white : Colors.black,
                  fontSize: SizeConfig.scaleTextFont(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          onPressed: () {},
          icon: Icon(
            Icons.sort,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              end: SizeConfig.scaleWidth(16),
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: allRecipes == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
        // physics: NeverScrollableScrollPhysics(),
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          MainPageScreen(allRecipes, selected,editFunction),
          AddRecipeScreen(),
          FavoriteScreen(allRecipes,editFunction),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
      color: AppColors.MAIN_COLOR.withOpacity(0.8),
      elevation: 0,
      child: TabBar(
        controller: controller,
        tabs: [
          Tab(
            text: "Home",
            icon: Icon(Icons.home),
          ),
          Tab(
            text: "Add",
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
          Tab(
            text: "Favorite",
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
    ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addFunc(
            Recipe(
              title: 'Chicken Fried Rice',
              description: 'So irresistibly delicious',
              image: 'images/chicken_fried_rice.png',
              calories: 250,
              carbo: 35,
              protein: 6,
              ingredients: '''
 - 2 tablespoons sesame oil
 - 2 tablespoons  vegetable oil
 - 3/4 to 1 pound boneless skinless chicken breasts
 - 1 1/2 cups frozen peas and diced carrots blend
 - 3 green onions, trimmed and sliced into thin rounds
 - 2 to 3 garlic cloves, finely minced
 - 3 large eggs, lightly beaten
 - 4 cups cooked rice
 - 3 to 4 tablespoons low-sodium soy sauce
 - salt and pepper, optional and to taste
              ''',
              preparation: '''
- STEP 1
To a large non-stick skillet or wok, add the oils, chicken,and cook over medium-high heat for about 3 to 5 minutes, flipping intermittently so all sides cook evenly. Cooking time will vary based on thickness of chicken breasts and sizes of pieces.

- STEP 2
Remove chicken with a slotted spoon (allow oils and cooking juices from chicken to remain in skillet) and place chicken on a plate; set aside.

- STEP 3
Add the peas, carrots, green onions, and cook for about 2 minutes, or until vegetables begin to soften, stir intermittently.

- STEP 4
Add the garlic and cook for 1 minute, stir intermittently.

- STEP 5
Push vegetables to one side of the skillet, add the eggs to the other side, and cook to scramble, stirring as necessary.

- STEP 6
Add the chicken, rice, evenly drizzle with soy sauce, optional salt and pepper, and stir to combine. Cook for about 2 minutes, or until chicken is reheated through.
              ''',
            ),
          );
          // addFunc(
//             Recipe(
//               title: 'Pasta Bolognese',
//               description: 'True Italian classic with a meaty, chilli sauce',
//               image: 'images/pasta_bolognese.png',
//               calories: 200,
//               carbo: 45,
//               protein: 10,
//               ingredients: '''
// - 2 tbsp olive oil
// - 400g/14oz beef mince
// - 1 onion, diced
// - 2 garlic cloves, chopped
// - 100g/3½oz carrot, grated
// - 2 x 400g tin chopped tomatoes
// - 400ml/14fl oz stock
// - 400g/14oz dried spaghetti
// - salt and pepper
// ''',
//               preparation: '''
// - STEP 1
// Heat a large saucepan over a medium heat. Add a tablespoon of olive oil and once hot add the beef mince and a pinch of salt and pepper. Cook the mince until well browned over a medium-high heat (be careful not to burn the mince. It just needs to be a dark brown colour). Once browned, transfer the mince to a bowl and set aside.
//
// - STEP 2
// Add another tablespoon of oil to the saucepan you browned the mince in and turnthe heat to medium. Add the onions and a pinch of salt and fry gently for 5-6 minutes,or until softened and translucent. Add the garlic and cook for another 2 minutes.Add the grated carrot then pour the mince and any juices in the bowl back into the saucepan.
//
// - STEP 3
// Add the tomatoes to the pan and stir well to mix. Pour in the stock, bring to a simmer and then reduce the temperature to simmer gently for 45 minutes, or until the sauce is thick and rich. Taste and adjust the seasoning as necessary.
//
// - STEP 4
// When ready to cook the spaghetti, heat a large saucepan of water and add a pinch of salt. Cook according to the packet instructions. Once the spaghetti is cooked through, drain and add to the pan with the bolognese sauce. Mix well and serve.
//               '''
//             ),
//           );
//           addFunc(
//             Recipe(
//               title: 'Garlic Potatoes',
//               description: 'Crispy Garlic Roasted Potatoes',
//               image: 'images/filete_con_papas_cambray.png',
//               calories: 150,
//               carbo: 30,
//               protein: 8,
//               ingredients: '''
// - 3 pounds small red or white potatoes
// - 1/4 cup good olive oil
// - 1 1/2 teaspoons kosher salt
// - 1 teaspoon freshly ground black pepper
// - 2 tablespoons minced garlic (6 cloves)
// - 2 tablespoons minced fresh parsley
//               ''',
//               preparation: '''
// - STEP 1
// Preheat the oven to 400 degrees F.
//
// - STEP 2
// Cut the potatoes in half or quarters and place in a bowl with the olive oil, salt, pepper, and garlic; toss until the potatoes are well coated. Transfer the potatoes to a sheet pan and spread out into 1 layer. Roast in the oven for 45 minutes to 1 hour or until browned and crisp. Flip twice with a spatula during cooking in order to ensure even browning.
//
// - STEP 3
// Remove the potatoes from the oven, toss with parsley, season to taste, and serve hot.
//               '''
//             ),
//           );
//           addFunc(
//             Recipe(
//               title: 'Asparagus',
//               description: 'White Onion, Fennel, and watercress Salad',
//               image: 'images/asparagus.png',
//               calories: 190,
//               carbo: 35,
//               protein: 12,
//               ingredients: '''
// - 1 pound white or green asparagus
// - 3 1/2 tablespoons unsalted butter
// - 1 ounce thinly sliced prosciutto
// - 1 pound sea scallops
// - Salt and freshly ground pepper
// - 1/2 teaspoon finely grated lemon zest
// - 2 tablespoons fresh lemon juice
// - 1/4 cup chicken stock
//               ''',
//               preparation: '''
// - STEP 1
// Cook the asparagus in a large sauce-pan of boiling salted water until tender, about 8 minutes. Using tongs, transfer the asparagus to a colander and leave the pan of water simmering on the stove.
//
// - STEP 2
// Melt 1 tablespoon of the butter in a large skillet. Add the prosciutto and cook over low heat until crisp, about 4 minutes. Transfer the prosciutto to a plate.
//
// - STEP 3
// Melt 2 tablespoons of the butter in the skillet. Add the scallops, season with salt and pepper and cook over moderately high heat until browned, about 2 minutes per side. Transfer the scallops to a plate.
//
// - STEP 4
// Add the lemon zest to the skillet and cook over moderate heat until browned, about 1 minute. Add the lemon juice and simmer for 10 seconds. Add the stock and simmer, scraping the bottom of the skillet, until reduced to a rich glaze, about 3 minutes. Swirl in the remaining 1/2 tablespoon of butter. Return the scallops, along with any juices, to the skillet and cook over low heat until heated through.
//
// - STEP 5
// Return the asparagus to the simmering water to heat through. Season the sauce with salt and pepper. Using tongs, transfer the asparagus to a large platter and spoon the scallops and sauce over it. Top with the fried prosciutto and serve.'''
//             ),
//           );
//           addFunc(
//             Recipe(
//               title: 'Filet Mignon',
//               description: 'Bacon-Wrapped Filet Mignon',
//               image: 'images/steak_bacon.png',
//               calories: 250,
//               carbo: 55,
//               protein: 20,
//               ingredients: '''
// - 6 oz filet mignon (170 g)
// - coarse salt, to taste
// - freshly ground black pepper
// - 1 tablespoon grapeseed oil
// - 2 tablespoons unsalted butter
// - 2 sprigs fresh rosemary
// - 1 clove garlic''',
//               preparation: '''
// - STEP 1
// On a cutting board, pat the filet mignon dry with paper towels and let sit at room temperature for 20-30 minutes.
//
// - STEP 2
// Preheat the oven to 450˚F (230˚C).
//
// - STEP 3
// Generously season all sides of the filet mignon with salt and pepper.
//
// - STEP 4
// Heat a medium, oven-safe stainless steel or cast iron skillet over high heat for 5 minutes. Add the grapeseed oil.
//
// - STEP 5
// Once the oil beings to smoke, add the filet mignon to the pan. Cook without moving for 2-3 minutes, until a crust has formed.
//
// - STEP 6
// Use tongs to flip the steak over, then add the butter, rosemary, and garlic to the pan.
//
// - STEP 7
// Tilt the pan and spoon the butter continuously over the steak for 2-3 minutes.
//
// - STEP 8
// Transfer the pan to the oven for 7 minutes for a medium rare steak.
//
// - STEP 9
// Transfer the steak to a cutting board and let rest for at least 10 minutes before slicing.
//               '''
//             ),
//           );
          setState(() {});
        },
        child: Icon(Icons.create),
      ),

    );
  }
}
