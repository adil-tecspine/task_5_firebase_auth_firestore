import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/home_screen.dart';
import 'package:task_5_firebase_auth_firestore/login_screen.dart';

class SplashScreenController extends GetxController {
  final AuthRepository authRepository;

  SplashScreenController() : authRepository = AuthRepository();

  @override
  void onReady() {
    super.onReady();
    fetchUser();
  }

  // method to fetch the current user from the repoo and if the user is null move him to login screen otherwise to the homescreen
  void fetchUser() async {
    final user = authRepository.currentUser;
    if (user == null) {
      Get.off(() => const LoginScreen());
    } else {
      Get.off(() => const HomeScreen());
    }
  }
}
