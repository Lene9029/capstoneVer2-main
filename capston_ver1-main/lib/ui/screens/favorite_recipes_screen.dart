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
            backgroundColor: Colors.lightGreen,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Favorite Recipes'),
                SizedBox(
                  height: 4,
                ),
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
          body: GridView.builder(
    padding: const EdgeInsets.all(10), // Padding around the grid
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // Number of columns in the grid
      childAspectRatio: 0.75, // Aspect ratio of each grid item
      crossAxisSpacing: 10, // Horizontal spacing between grid items
      mainAxisSpacing: 10, // Vertical spacing between grid items
    ),
    itemCount: myProvider.favoriteRecipes.length, // Total number of items
    itemBuilder: (context, index) {
      return RecipeWidget(myProvider.favoriteRecipes[index]); // Your RecipeWidget
    },
  ),
          
        );
      },
    );
  }
}
