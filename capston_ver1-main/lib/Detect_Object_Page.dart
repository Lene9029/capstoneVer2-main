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

class detect_object_page extends StatefulWidget {
  const detect_object_page({Key? key}) : super(key: key);

  @override
  State<detect_object_page> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<detect_object_page> {
  late ModelObjectDetection _objectModel;
  List<ResultObjectDetection?> objDetect = [];
  File? _image;
  ImagePicker _picker = ImagePicker();
  bool firststate = false;
  bool message = true;
  List<String> classNames = [];

  @override
  void initState() {
    super.initState();
    loadModel();
    runObjectDetection();
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

  void handleTimeout() {
    setState(() {
      firststate = true;
    });
  }

  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds: milliseconds), handleTimeout);

  Future<void> runObjectDetection() async {
    setState(() {
      firststate = false;
      message = false;
    });

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    try {
      objDetect = await _objectModel.getImagePrediction(
        await File(image!.path).readAsBytes(),
        minimumScore: 0.1,
        IOUThershold: 0.3,
      );

      classNames = [];
      for (var detection in objDetect) {
        classNames.add(detection?.className ?? '');
      }

      scheduleTimeout(5 * 1000);
      setState(() {
        _image = File(image.path);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Image Detected')));
    }
  }

  resultData() {
    var result = classNames;
  }

  Future<void> runObjectDetectionAgain() async {
    setState(() {
      message = false;
    });

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    objDetect = await _objectModel.getImagePrediction(
      await File(image!.path).readAsBytes(),
      minimumScore: 0.1,
      IOUThershold: 0.3,
    );

    // Extract class names
    classNames = [];
    for (var detection in objDetect) {
      classNames.add(detection?.className ?? '');
    }

    scheduleTimeout(5 * 1000);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context);
    final allergensProvider = Provider.of<AlleresProvider>(context);

    return Scaffold(
          bottomNavigationBar: BottomAppBar(
                color: Colors.lightGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => detect_object_page()));
                        },
                        child: const Icon(Icons.camera)),
                  ],
                ),
              ),
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.green,
                      Colors.lightGreen
                    ])
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !firststate
                          ? !message
                              ? LoaderState()
                              : Text("Select the Camera to Begin Detections")
                          : Expanded(
                              child: Container(
                                child: _objectModel.renderBoxesOnImage(
                                    _image!, objDetect),
                              ),
                            ),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          runObjectDetectionAgain();
                        },
                        child: Text('Retake Photo'),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          
                          Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => MultiProvider(
      providers: [
        Provider.value(value: myProvider),  // Passing RecipeClass
        Provider.value(value: allergensProvider),  // Passing AlleresProvider
      ],
      child: ShowRecipeWithIngredients(
        resultData: classNames,
        recipes: myProvider.allRecipes, // Accessing RecipeClass data
        allergens: allergensProvider.allergens, // Accessing AlleresProvider data
        restrictions: allergensProvider.restrictions, // Accessing AlleresProvider data
      ),
    ),
  ),
);

                        },
                        child: const Text('View Recipe'),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}
