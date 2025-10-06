import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_5_firebase_auth_firestore/my_app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
