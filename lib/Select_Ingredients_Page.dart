import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/Selected_Ingredients_Result.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';

class SelecIgredientsPage extends StatefulWidget {
  const SelecIgredientsPage({super.key});

  @override
  State<SelecIgredientsPage> createState() => _SeelecIgredientsPageState();
}

class _SeelecIgredientsPageState extends State<SelecIgredientsPage> {
  final List<String> _ingredientchoices = [
    'ampalaya',
    'bangus',
    'bay-leaves',
    'beef',
    'beef-intestines',
    'beef-kidney',
    'beef-ribs',
    'beef-tail',
    'beef-tripe',
    'bokchoy',
    'breadcrumbs',
    'broccoli',
    'brown-sugar',
    'butter',
    'cabbage',
    'calamansi',
    'cashew-nuts',
    'cauliflower',
    'celery',
    'cellophane noodles',
    'chayote',
    'chicharon',
    'chicken',
    'chicken-bouillon-granules',
    'chickpeas',
    'chorizo',
    'cloves',
    'corn',
    'dried-shitake-mushrooms',
    'egg',
    'eggplant',
    'garlic',
    'ginger',
    'green-beans',
    'ham',
    'hotdog',
    'kanduli',
    'kangkong',
    'lemon',
    'lumpia-wrapper',
    'mackerel',
    'malungay-leaves',
    'mung-beans',
    'mussels',
    'okra',
    'olive',
    'onion',
    'parsley',
    'pata',
    'pork-heart',
    'pork-liver',
    'pork-loin',
    'pork-lung',
    'pork-meat',
    'pork-ribs',
    'pork-shoulder',
    'pork-skin',
    'potato',
    'puso-ng-saging',
    'raisins',
    'red-chili-pepper',
    'rice',
    'saba-banana',
    'salmon',
    'sesame-seeds',
    'singkamas',
    'sitaw',
    'spinach',
    'spring-onions',
    'tomato'
  ];

  late List<bool> _selectedIngredientChoices = [];

  @override
  void initState() {
    super.initState();
    _selectedIngredientChoices =
        List<bool>.filled(_ingredientchoices.length, false);
  }

  List<String> getSelectedIngredients() {
    List<String> selectedIngredientChoices = [];

    for (int i = 0; i < _ingredientchoices.length; i++) {
      if (_selectedIngredientChoices[i]) {
        selectedIngredientChoices.add(_ingredientchoices[i]);
      }
    }

    return selectedIngredientChoices;
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context);
    final allergensProvider = Provider.of<AlleresProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView( // Add SingleChildScrollView here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Choose Your Ingredients',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 8.0,
                                children: List<Widget>.generate(
                                    _ingredientchoices.length, (int index) {
                                  return ChoiceChip(
                                    label: Text(_ingredientchoices[index]),
                                    selected: _selectedIngredientChoices[index],
                                    onSelected: (bool selected) {
                                      setState(() {
                                        _selectedIngredientChoices[index] =
                                            selected;
                                      });
                                    },
                                  );
                                }),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  var resultData = getSelectedIngredients();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MultiProvider(
                                        providers: [
                                          Provider.value(
                                              value: myProvider.allRecipes),
                                          Provider.value(
                                              value: allergensProvider.allergens),
                                          Provider.value(
                                              value: allergensProvider.restrictions),
                                        ],
                                        child: SelectedIngredientsResult(
                                          resultData: resultData,
                                          recipes: myProvider.allRecipes,
                                          allergens: allergensProvider.allergens,
                                          restrictions:
                                              allergensProvider.restrictions,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Submit Ingredients'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
