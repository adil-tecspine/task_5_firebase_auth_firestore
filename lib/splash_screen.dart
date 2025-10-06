import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/splash_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final controller = Get.put(SplashScreenController());

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
