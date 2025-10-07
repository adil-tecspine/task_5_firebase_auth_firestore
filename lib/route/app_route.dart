import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/bindings/home_screen_binding.dart';
import 'package:task_5_firebase_auth_firestore/bindings/login_screen_binding.dart';
import 'package:task_5_firebase_auth_firestore/bindings/signup_screen_binding.dart';
import 'package:task_5_firebase_auth_firestore/bindings/splash_screen_binding.dart';
import 'package:task_5_firebase_auth_firestore/home_screen.dart';
import 'package:task_5_firebase_auth_firestore/login_screen.dart';
import 'package:task_5_firebase_auth_firestore/registration_screen.dart';
import 'package:task_5_firebase_auth_firestore/route/route_names.dart';
import 'package:task_5_firebase_auth_firestore/signup_screen.dart';
import 'package:task_5_firebase_auth_firestore/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static const String initialRoute = RouteNames.splash;

  static final routes = <GetPage<dynamic>>[
    GetPage<SplashScreen>(
      name: RouteNames.splash,
      page: () => const SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage<LoginScreen>(
      name: RouteNames.login,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage<SignupScreen>(
      name: RouteNames.signup,
      page: () => const SignupScreen(),
      binding: SignupScreenBinding(),
    ),
    GetPage<RegistrationScreen>(
      name: RouteNames.register,
      page: () => const RegistrationScreen(),
      binding: SignupScreenBinding(),
    ),
    GetPage<HomeScreen>(
      name: RouteNames.home,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
  ];
}
