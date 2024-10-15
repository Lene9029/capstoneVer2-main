import 'dart:ui';

import 'package:flutter/material.dart';

class SeelecIgredientsPage extends StatefulWidget {
  const SeelecIgredientsPage({super.key});

  @override
  State<SeelecIgredientsPage> createState() => _SeelecIgredientsPageState();
}

class _SeelecIgredientsPageState extends State<SeelecIgredientsPage> {

  final List<String> _ingredientchoices = [
    'Barley',
    'Celeriac',
    'Celery',
    'Citrus fruit',
    'Corn',
    'Egg',
    'Fish',
    'Latex',
    'Lupin',
    'Milk',
    'Mustard',
    'Nickel allergy',
    'Oats',
    'Oral allergy syndrome',
    'Peanut',
    'Rice',
    'Rye',
    'Seeds',
    'Sesame',
    'Shellfish',
    'Soy',
    'Tree nut',
    'Wheat'
  ];
  
  late List<bool> _selectedIngredientChoices = [];

  @override
  void initState() {
    super.initState();
    _selectedIngredientChoices = List<bool>.filled(_ingredientchoices.length, false); 
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
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //decoration: const BoxDecoration(
         // image: DecorationImage(image: AssetImage('images/diet.jpg'),
         // fit: BoxFit.cover)
       // ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Center(
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
                            const Text('Choose Your Ingredients',
                            style: TextStyle(fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20,),
                            Wrap(
                              spacing: 8.0,
                              children: List<Widget>.generate(
                                _ingredientchoices.length, 
                                (int index) {
                                  return ChoiceChip(label: Text(_ingredientchoices[index]),
                                   selected: _selectedIngredientChoices[index],
                                   onSelected: (bool selected){
                                    setState(() {
                                      _selectedIngredientChoices[index] = selected;
                                    });
                                   },
                                  );
                                }),
                            )
                          ]
                          
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),     
    );
  }
}