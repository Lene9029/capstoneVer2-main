import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/screens/show_recipe_screen.dart';
import '../../models/recipe_model.dart';

class RecipeWidget extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeWidget(this.recipeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowRecipeScreen(recipeModel: recipeModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: !Provider.of<RecipeClass>(context).isDark ? const Color.fromARGB(255, 173, 117, 97) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: recipeModel.image == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark ? Colors.blue : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/food_logo.png'),
                          radius: 35, // Adjust the radius as needed
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        recipeModel.image!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 8), // Spacing between image and text
            Text(
              recipeModel.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center, // Center align the title
            ),
            const SizedBox(height: 4), // Spacing between title and subtitle
            Text(
              '${recipeModel.preperationTime} mins',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center, // Center align the subtitle
            ),
            const SizedBox(height: 4), // Spacing before the favorite icon
            IconButton(
              onPressed: () {
                Provider.of<RecipeClass>(context, listen: false)
                    .updateIsFavorite(recipeModel);
              },
              icon: recipeModel.isFavorite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
