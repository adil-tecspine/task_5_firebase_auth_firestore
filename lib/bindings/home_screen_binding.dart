import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(() => HomeScreenController());
  }
}
