import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/models/recipe_model.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/ui/widgets/recipe_widget.dart';

// ignore: must_be_immutable
class ShowRecipeWithIngredients extends StatefulWidget {
  ShowRecipeWithIngredients({
    super.key,
    required this.recipes,
    required this.resultData,
    required this.allergens,
    required this.restrictions
  });

  State<ShowRecipeWithIngredients> createState() => _SearchRecipeScreenState();

  final List<RecipeModel> recipes;
  List<RecipeModel> filteredRecipes = [];
  final List<String> resultData;
  List<RecipeModel> filteredRecipe = [];
  final  List<String> allergens;
  final List<String> restrictions;
 
}

class _SearchRecipeScreenState extends State<ShowRecipeWithIngredients> {
  late List<RecipeModel> _filteredRecipes;
  List<RecipeModel> _filteredRecipe = [];
  
  List<RecipeModel> filteredFinal = []; 
  List<RecipeModel> filteredrestrictions = []; 
  List<RecipeModel> filteredA = [];
  List<RecipeModel> filteredR = []; 

  void filterRecipe(String value) {
    setState(() {
      _filteredRecipes = filteredFinal
          .where((recipe) =>
              recipe.ingredients.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  _filterRecipes(List<String> resultData) {
    setState(() {
      for (var ingredient in resultData) {
        _filteredRecipes = widget.recipes.where((recipe) {
          return recipe.ingredients.toLowerCase().contains(ingredient);
        }).toList();
        
        print(widget.allergens);
        print(widget.restrictions);

        _filteredRecipe.addAll(_filteredRecipes);

        filteredA = _filteredRecipes.where((recipe) {
  return !widget.allergens.any((allergen) =>
      recipe.allergensName.toLowerCase().contains(allergen.toLowerCase()));
}).toList();

        
        

filteredR = filteredA.where((recipe) {
  return !widget.restrictions.any((restriction) =>
      recipe.restrictions.toLowerCase().contains(restriction.toLowerCase()));
}).toList();

      }
      filteredFinal = filteredR.toSet().toList();
    });
  }

  @override
  void initState() {
    _filterRecipes(widget.resultData);
    super.initState();
    print(widget.allergens);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            filterRecipe(value);
          },
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search Recipe",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: filteredFinal.isNotEmpty
            ? ListView.builder(
                itemCount: filteredFinal.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeWidget(filteredFinal[index]);
                },
              )
            : const Center(
                child: Text('Recipe not found...'),
              ),
      ),
    );
  }
}
