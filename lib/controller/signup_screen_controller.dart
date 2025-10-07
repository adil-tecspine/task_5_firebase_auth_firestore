import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/home_screen.dart';

class SignupScreenController extends GetxController {
  final AuthRepository authRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  SignupScreenController() : authRepository = AuthRepository();

  void signupWithEmailPassword(String email, String password) async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Signing Up',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.createUserWithEmailAndPassword(
        email,
        password,
      );

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Signup failed.');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Your account has been created successfully');
        Get.off(() => const HomeScreen());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Signup failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }
}
