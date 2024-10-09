import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pytorch/pigeon.dart';
import 'package:flutter_pytorch/flutter_pytorch.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/LoaderState.dart';
import 'package:recipe_page_new/providers/alleres_provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/show_recipe.dart';

class DetectObjectPage extends StatefulWidget {
  const DetectObjectPage({Key? key}) : super(key: key);

  @override
  State<DetectObjectPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DetectObjectPage> {
  late ModelObjectDetection _objectModel;
  List<ResultObjectDetection?> objDetect = [];
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;
  List<String> classNames = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    String pathObjectDetectionModel = "assets/models/ingredients.torchscript";
    try {
      _objectModel = await FlutterPytorch.loadObjectDetectionModel(
        pathObjectDetectionModel,
        4,
        640,
        640,
        labelPath: "assets/labels/labels.txt",
      );
    } catch (e) {
      if (e is PlatformException) {
        print("only supported for android, Error is $e");
      } else {
        print("Error is $e");
      }
    }
  }

  Future<void> runObjectDetection() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        isLoading = true; // Start the loader when image is picked
        _image = File(image.path);
      });

      try {
        objDetect = await _objectModel.getImagePrediction(
          await File(image.path).readAsBytes(),
          minimumScore: 0.1,
          IOUThershold: 0.3,
        );

        classNames = objDetect
            .map((detection) => detection?.className ?? '')
            .where((name) => name.isNotEmpty)
            .toList();

        setState(() {
          isLoading = false; // Stop loader after object detection is done
        });
      } catch (e) {
        setState(() {
          isLoading = false; // Ensure loader stops even on error
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No Image Detected')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context);
    final allergensProvider = Provider.of<AlleresProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image == null)
              const Text("Please Take a Picture")
            else if (isLoading)
              const LoaderState() // Show the loader when processing the image
            else
              Expanded(
                child: Container(
                  child: _objectModel.renderBoxesOnImage(_image!, objDetect),
                ),
              ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: runObjectDetection,
              child: const Text('Take a photo'),
            ),
            ElevatedButton(
              onPressed: () {
                if (classNames.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          Provider.value(value: myProvider.allRecipes),
                          Provider.value(value: allergensProvider.allergens),
                          Provider.value(value: allergensProvider.restrictions),
                        ],
                        child: ShowRecipeWithIngredients(
                          resultData: classNames,
                          recipes: myProvider.allRecipes,
                          allergens: allergensProvider.allergens,
                          restrictions: allergensProvider.restrictions,
                        ),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No Ingredients detected!')),
                  );
                }
              },
              child: const Text('View Recommendations'),
            ),
          ],
        ),
      ),
    );
  }
}
