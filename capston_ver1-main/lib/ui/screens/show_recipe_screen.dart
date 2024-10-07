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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      provider.allergensNameController.text =
                          recipeModel.allergensName;
                          provider.restrictionsController.text =
                          recipeModel.restrictions;
                      provider.nameController.text = recipeModel.name;
                      provider.preperationTimeController.text =
                          recipeModel.preperationTime.toString();
                      provider.ingredientsController.text =
                          recipeModel.ingredients;
                      provider.instructionsController.text =
                          recipeModel.instructions;
                      provider.image = recipeModel.image;
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
                  if (recipeModel.image != null)
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          recipeModel.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 10,
                    ),
                  
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      recipeModel.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
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
                                ? Colors.green.withOpacity(0.7)
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Allergens',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              recipeModel.allergensName,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: !Provider.of<RecipeClass>(context).isDark
                                ? Colors.green.withOpacity(0.7)
                                : null,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Restrictions',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              recipeModel.restrictions,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.green.withOpacity(0.7)
                            : null,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Text(
                          'Preparation time:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${recipeModel.preperationTime} mins',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildDetailsSection(
                      'Ingredients', recipeModel.ingredients),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildDetailsSection(
                      'Instructions', recipeModel.instructions),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildDetailsSection(
                      'Allergen Statement', recipeModel.allergenStatement),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildDetailsSection('Restriction Statement',
                      recipeModel.restrictionStatement),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildDetailsSection(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            content,
            style: const TextStyle(fontSize: 26, color: Colors.white),
          )
        ],
      ),
    );
  }
}
