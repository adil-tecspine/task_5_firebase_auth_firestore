import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/splash_screen_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}
