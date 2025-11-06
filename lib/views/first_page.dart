import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../controllers/theme_controller.dart';
import 'home_page.dart';

class FirstPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter GitHub Username'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'GitHub Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (usernameController.text.isEmpty) {
                  Get.snackbar('Error', 'Please enter a username');
                  return;
                }
                try {
                  var response = await Dio().get('https://api.github.com/users/${usernameController.text}');
                  if (response.statusCode == 200) {
                    Get.to(() {
                      return HomePage(username: usernameController.text);
                    });
                  }
                } catch (e) {
                  Get.snackbar('Error', 'User not found');
                }
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}