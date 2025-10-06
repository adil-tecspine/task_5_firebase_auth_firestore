import 'package:flutter/material.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: Dimen.s20,
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterLogo(size: Dimen.s100),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
