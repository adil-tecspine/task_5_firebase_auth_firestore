import 'package:flutter/material.dart';
import 'package:task_5_firebase_auth_firestore/update_profile_widget.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(Dimen.s16),
        child: Center(
          child: Card(
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
        ),
      ),
    );
  }
}
