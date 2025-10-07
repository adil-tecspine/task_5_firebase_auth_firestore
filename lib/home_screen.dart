import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/home_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/update_profile_widget.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(Dimen.s16),
        child: Center(
          child: Column(
            spacing: Dimen.s20,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  title: Text('Adil Azhar'),
                  subtitle: Text('adilazhar6015@gmail.com'),
                  trailing: Icon(Icons.email),

                  // tapping on the listitle opens up a dilaog with the name field to update the name of the person
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => UpdateProfileWidget('Adil Azhar'),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.logout();
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
