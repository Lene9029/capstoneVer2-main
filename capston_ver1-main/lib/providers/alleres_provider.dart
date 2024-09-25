import 'package:flutter/material.dart';

class AlleresProvider extends ChangeNotifier {
  String allergens = '';
  String restrictions = '';

  

  void updateAllergens(String selectedAllergens) {
    allergens = selectedAllergens;
    notifyListeners();
  }

  void updateRestrictions(String selectedRestrictions) {
    restrictions = selectedRestrictions;
    notifyListeners();
  }
}
