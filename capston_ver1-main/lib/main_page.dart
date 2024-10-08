import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_page_new/Detect_Object_Page.dart';
import 'package:recipe_page_new/profile_page.dart';
import 'package:recipe_page_new/ui/screens/all_recipe_screen.dart';
import 'package:recipe_page_new/ui/screens/favorite_recipes_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () =>  NavigationBar(
          height: 60,
          elevation: 5,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [ 
            NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Recipes'),
            NavigationDestination(icon: Icon(Icons.camera), label: 'Camera'),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Favorites'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
          ],),
      ),
        body: Obx (() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const MainRecipeScreen(),
    const DetectObjectPage(),
    const FavoriteRecipesScreen(),
    ProfilePage()
  ];
}