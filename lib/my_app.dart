import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_5_firebase_auth_firestore/route/app_route.dart';
import 'package:task_5_firebase_auth_firestore/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Firebase Auth & Firestore',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: SplashScreen(),
      initialRoute: AppRoute.initialRoute,
      getPages: AppRoute.routes,
    );
  }
}
