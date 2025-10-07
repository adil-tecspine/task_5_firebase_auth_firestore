import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/login_screen_controller.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
  }
}
