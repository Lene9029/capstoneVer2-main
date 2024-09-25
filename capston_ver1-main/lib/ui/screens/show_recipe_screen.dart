import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';

import 'edit_recipe_screen.dart';

class ShowRecipeScreen extends StatelessWidget {
  final RecipeModel recipeModel;

  const ShowRecipeScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: ((context, provider, child) => Scaffold(
          appBar: AppBar(
                backgroundColor: Colors.lightGreen,
                actions: [
                  InkWell(
                      onTap: () {
                        provider.allergensNameController.text = recipeModel.restrictions;
                        provider.nameController.text = recipeModel.name;
                        provider.preperationTimeController.text =
                            recipeModel.preperationTime.toString();
                        provider.ingredientsController.text =
                            recipeModel.ingredients;
                        provider.instructionsController.text =
                            recipeModel.instructions;
                        provider.image = recipeModel.image;
                        provider.allergensNameController.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditRecipeScreen(
                                    recipeModel: recipeModel))));
                      },
                      child: const Icon(Icons.edit)),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        provider.deleteRecipe(recipeModel);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.delete)),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.lightGreen,
                          Colors.green
                        ]
                      ),
                    ),
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: !Provider.of<RecipeClass>(context).isDark
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(5)),
                      height: 170,
                      //width: double.infinity,
                      child: recipeModel.image == null
                          ? const Center(
                              child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('images/food_logo.png'),
                            ))
                          : Image.file(
                              recipeModel.image!,
                            ),
                    ),
                    
                    
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        recipeModel.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  
                    Row(
                      children: [
                        Container(
                          width: 200,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: !Provider.of<RecipeClass>(context).isDark
                                  ? Colors.green
                                  : null,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'allergens',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              
                              
                              Text(
                                recipeModel.allergensName,
                                style: const TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                         Expanded(child: Container(
                          width: double.infinity,
                         )),
                        
                        Container(
                     width: 200,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: !Provider.of<RecipeClass>(context).isDark
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Restrictions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          
                          
                          Text(
                            recipeModel.restrictions,
                            style: const TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: !Provider.of<RecipeClass>(context).isDark
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Text(
                            'Preperation time :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${recipeModel.preperationTime} mins',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: !Provider.of<RecipeClass>(context).isDark
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            recipeModel.ingredients,
                            style: const TextStyle(fontSize: 26),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: !Provider.of<RecipeClass>(context).isDark
                              ? Colors.green
                              : null,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Instructions',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            recipeModel.instructions,
                            style: const TextStyle(fontSize: 26),
                          )
                        ],
                      ),
                    ),
                     
                    
                  ]),
                ),
              ),
            )));
  }
}
