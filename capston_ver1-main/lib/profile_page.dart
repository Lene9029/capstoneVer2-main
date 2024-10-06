import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_page_new/providers/recipe_provider.dart';
import 'package:recipe_page_new/welcomepage/welcome_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<RecipeClass>(context); 

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        title: const Text('Profile'),
        backgroundColor: myProvider.isDark ? Colors.grey[900] : Colors.brown,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: myProvider.isDark ? Colors.grey[850] : Colors.brown,
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('images/logo.png'),
                radius: 60,
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Change Allergens and Restrictions'),
                  leading: const Icon(
                    Icons.change_circle_outlined,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => welcomepage()));
                  },
                ),
                myProvider.isDark
                    ? ListTile(
                        title: const Text('Change Theme'),
                        leading: const Icon(
                          Icons.light_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false).changeIsDark();
                          Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        title: const Text('Change Theme'),
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false).changeIsDark();
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
