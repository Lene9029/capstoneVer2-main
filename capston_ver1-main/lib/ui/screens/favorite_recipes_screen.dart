import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recipe_page_new/ui/screens/search_recipe_screen.dart';

import '../../providers/recipe_provider.dart';
import '../widgets/recipe_widget.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Recipes'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Favorite Recipes:',
                  style: TextStyle(
                    fontSize: 16,
                    color: !myProvider.isDark
                        ? Colors.black
                        : null,
                  ),
                )
              ],
            ),
            actions: [
              InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchRecipeScreen(
                          recipes: myProvider.favoriteRecipes)))),
                  child: const Icon(Icons.search)),
            ],
          ),
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.lightGreen : null,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: !myProvider.isDark ? Colors.green : null,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/food_logo.png'),
                      radius: 50,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/main_recipe_screen');
                  },
                ),
                ListTile(
                  title: const Text('Favorite Recipes'),
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite_recipes_screen');
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                Provider.of<RecipeClass>(context).isDark
                    ? ListTile(
                        title: const Text('Light Mode'),
                        leading: const Icon(
                          Icons.light_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        title: const Text('Change Theme'),
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.green,
                  Colors.lightGreen
                ]
                ),
            ),
            child: ListView.builder(
                itemCount: myProvider.favoriteRecipes.length,
                itemBuilder: (context, index) {
                  return RecipeWidget(myProvider.favoriteRecipes[index]);
                }),
          ),
        );
      },
    );
  }
}
