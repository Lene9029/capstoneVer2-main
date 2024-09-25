import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recipe_page_new/Detect_Object_Page.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/screens/search_recipe_screen.dart';

import '../widgets/recipe_widget.dart';

class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
              appBar: AppBar(
                title: const Text('All Recipes'),
                centerTitle: true,
                backgroundColor: Colors.lightGreen,
                actions: [
                  InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SearchRecipeScreen(
                              recipes: myProvider.allRecipes)))),
                      child: const Icon(Icons.search)),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (() async {
                  await Navigator.pushNamed(context, '/new_recipe_screen');
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                      context, '/main_recipe_screen');
                }),
                child: const Icon(Icons.add),
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
                        Navigator.pushReplacementNamed(
                            context, '/main_recipe_screen');
                      },
                    ),
                     const Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      title: const Text('Favorite Recipes'),
                      leading: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/favorite_recipes_screen');
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    
                    Provider.of<RecipeClass>(context).isDark
                        ? ListTile(
                            title: const Text('Change Theme'),
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
              bottomNavigationBar: BottomAppBar(
                color: Colors.lightGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => detect_object_page()));
                        },
                        child: const Icon(Icons.camera)),
                  ],
                ),
              ),
              body: ListView.builder(
                  itemCount: myProvider.allRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeWidget(myProvider.allRecipes[index]);
                  }),
            ));
  }
}
