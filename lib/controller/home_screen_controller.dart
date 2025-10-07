import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/login_screen.dart';

class HomeScreenController extends GetxController {
  final AuthRepository authRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  HomeScreenController() : authRepository = AuthRepository();

  void logout() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Logging Out',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      await authRepository.signOut();
      status.value = RxStatus.success();
      Get.back();
      Get.snackbar('Success', 'Logout successful');
      // Navigate to login screen
      Get.off(() => const LoginScreen());
    } catch (e) {
      Get.back();
      log('Error in logout: $e');
      Get.snackbar('Error', 'Logout failed. ${e.toString()}');
      status.value = RxStatus.error(e.toString());
    }
  }

  void deleteAccount() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Deleting Account',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      await authRepository.deleteAccount();
      status.value = RxStatus.success();
      Get.back();
      Get.off(() => const LoginScreen());
      Get.snackbar('Success', 'Account deleted successfully');
    } catch (e) {
      Get.back();
      log('Error in deleteAccount: $e');
      Get.snackbar('Error', 'Account deletion failed. ${e.toString()}');
      status.value = RxStatus.error(e.toString());
    }
  }
}
