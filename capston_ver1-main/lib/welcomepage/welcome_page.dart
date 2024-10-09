import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/Detect_Object_Page.dart';


import 'package:recipe_page_new/main_page.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/ui/screens/favorite_recipes_screen.dart';
import 'package:recipe_page_new/ui/screens/all_recipe_screen.dart';
import 'package:recipe_page_new/ui/screens/new_recipe_screen.dart';
import 'package:recipe_page_new/WelcomePage/page_one_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {       
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      routes: {
        '/detect_screen':(context) => const DetectObjectPage(),
        '/favorite_recipes_screen': (context) => const FavoriteRecipesScreen(),
        '/new_recipe_screen': (context) => const NewRecipeScreen(),
        '/main_recipe_screen': (context) => const MainRecipeScreen(),
        
        
      },
    );
  }
}

class detect_object_page {
  const detect_object_page();
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final controller = OnboardingItems();
  int _currentPage = 0;

  final List<String> _allergenchoices = [
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

  final List<String> restrictionsChoices = [
    'Alpha gal',
    'Autoimmune protocol',
    'Breastfeeding',
    'Candida overgrowth',
    'Citric acid intolerance',
    'Dairy free',
    'Egg free',
    'Emulsifier free',
    'Eosinophilic esophagitis',
    'Fructose free',
    'Gerd',
    'Gluten free',
    'Interstitial cystitis',
    'Lactose free',
    'Low fodmap',
    'Low histamine',
    'Low iodine',
    'Low residue',
    'Mediterranean diet',
    'No beef',
    'No pork',
    'No poultry',
    'Paleo',
    'Pescatarian',
    'Plantricious',
    'Polycystic ovary syndrome',
    'Pregnancy',
    'Vegan',
    'Vegetarian',
    '30 paleo days'
  ];

  late List<bool> _selectedAllergenChoices;
  late List<bool> _selectedRestrictionsChoices;

  @override
  void initState() {
    super.initState();
    _selectedAllergenChoices = List<bool>.filled(_allergenchoices.length, false);
    _selectedRestrictionsChoices = List<bool>.filled(restrictionsChoices.length, false);
    
  }

  List<String> getSelectedAllergens() {
  List<String> selectedAllergenChoices = [];

  for (int i = 0; i < _allergenchoices.length; i++) {
    if (_selectedAllergenChoices[i]) {
      selectedAllergenChoices.add(_allergenchoices[i]);
    }
  }

  return selectedAllergenChoices;  
}


  List<String> getSelectedRestrictions(){
    List<String> selectedRestrictionsChoices = [];

    for (int i = 0; i < restrictionsChoices.length; i++){
      if (_selectedRestrictionsChoices[i]){
        selectedRestrictionsChoices.add(restrictionsChoices[i]);
      }
    }
    return selectedRestrictionsChoices;
  }

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      List<String> allergens = getSelectedAllergens();
      List<String> restrictions = getSelectedRestrictions();
      
      print(restrictions);
      print(allergens);
      
     final alleresProvider = Provider.of<AlleresProvider>(context, listen: false);
    alleresProvider.updateAllergens(allergens);
    alleresProvider.updateRestrictions(restrictions);
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(),));
      
    }
  } 

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      body: Stack(
        children: [PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: <Widget>[
            _buildPage1(),
            _buildPage2(),
            _buildPage3(),
            _buildPage4(),
          ],
        ),
        Container(alignment: const Alignment(0, 0.85),
          child: 
          SmoothPageIndicator(controller: _pageController, count: 4,
          effect:  const WormEffect(
            activeDotColor: Colors.green
          )),         
        )
      ])
    );
     
  }
  
  Widget _buildPage1() {
    return 
     Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(controller.items[0].image),
          fit: BoxFit.cover)
        ),
        child: const Text('Nutritious Recipe App')
      );
    
  }

  Widget _buildPage2() {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
           image: DecorationImage(image: AssetImage('images/allergy.jpg'),
           fit: BoxFit.cover),           
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'What Are Your Allergens?',
                            style: TextStyle(fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 8.0,
                            children: List<Widget>.generate(
                              _allergenchoices.length,
                              (int index) {
                                return ChoiceChip(
                                  label: Text(_allergenchoices[index]),
                                  selected: _selectedAllergenChoices[index],
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _selectedAllergenChoices[index] = selected;
                                    });
                                  },
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage3(){
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('images/diet.jpg'),
          fit: BoxFit.cover)
        ),
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
                            const Text('What Are Your Diets?',
                            style: TextStyle(fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20,),
                            Wrap(
                              spacing: 8.0,
                              children: List<Widget>.generate(
                                restrictionsChoices.length, 
                                (int index) {
                                  return ChoiceChip(label: Text(restrictionsChoices[index]),
                                   selected: _selectedRestrictionsChoices[index],
                                   onSelected: (bool selected){
                                    setState(() {
                                      _selectedRestrictionsChoices[index] = selected;
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
  Widget _buildPage4() {
  return Center(
    child: ElevatedButton(
      onPressed: _nextPage, 
      child: const Text(
        'Let\'s Get Started',
        style: TextStyle(fontSize: 30),
      ),
    ),
  );
}
}

  
