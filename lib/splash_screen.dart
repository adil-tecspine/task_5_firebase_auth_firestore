import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/splash_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashScreenController>();
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
