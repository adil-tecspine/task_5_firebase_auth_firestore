import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/signup_screen_controller.dart';

class SignupScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupScreenController>(() => SignupScreenController());
  }
}
