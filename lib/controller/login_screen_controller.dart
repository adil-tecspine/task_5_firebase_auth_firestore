import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/home_screen.dart';

class LoginScreenController extends GetxController {
  final AuthRepository authRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  LoginScreenController() : authRepository = AuthRepository();

  void loginWithEmailPassword(String email, String password) async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Logging In',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.signInWithEmailAndPassword(
        email,
        password,
      );

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Login failed. User is null');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Login successful');
        Get.off(() => const HomeScreen());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Login failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }

  // login with google
  void loginWithGoogle() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Logging In',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.signInWithGoogle();

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Login failed. User is null');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Login successful');
        Get.off(() => const HomeScreen());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Login failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }

  // login with facebook
  void loginWithFacebook() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Logging In',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.signInWithFacebook();

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Login failed. User is null');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Login successful');
        Get.off(() => const HomeScreen());
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Login failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }
}
