import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/ui/screens/show_recipe_screen.dart';

class NewRecipeWidget extends StatefulWidget {
  const NewRecipeWidget(this.recipeModel, {super.key});

  final RecipeModel recipeModel;

  @override
  State<NewRecipeWidget> createState() => _NewRecipeWidgetState();
}

class _NewRecipeWidgetState extends State<NewRecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 50,
            spreadRadius: 7,
            offset: const Offset(0, 2)
          )
        ],
        borderRadius: BorderRadius.circular(16),
        color: Colors.black
      ),
      child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowRecipeScreen(recipeModel: widget.recipeModel),
          ),
        );
      },
    child:  Stack(
      children: [
         widget.recipeModel.image == null
    ? Container(
        decoration: BoxDecoration(
          color: !Provider.of<RecipeClass>(context).isDark ? Colors.blue : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('images/food_logo.png'),
            radius: 35, 
          ),
        ),
      )
    : ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
          widget.recipeModel.image!,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(
                      onPressed: () {
                        Provider.of<RecipeClass>(context, listen: false)
                            .updateIsFavorite(widget.recipeModel);
                      },
                      icon: widget.recipeModel.isFavorite
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border, color: Colors.white),
                    ),
      ),
       Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.5), // Optional background to improve text visibility
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                widget.recipeModel.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )]
    ),)
    );
  }
}