import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/registration_screen_controller.dart';

class RegistrationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationScreenController>(
      () => RegistrationScreenController(),
    );
  }
}
