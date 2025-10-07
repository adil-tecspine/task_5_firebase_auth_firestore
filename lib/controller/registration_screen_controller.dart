import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/user_meta_repository.dart';
import 'package:task_5_firebase_auth_firestore/home_screen.dart';
import 'package:task_5_firebase_auth_firestore/models/user_meta.dart';

class RegistrationScreenController extends GetxController {
  final UserMetaRepository userMetaRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  RegistrationScreenController() : userMetaRepository = UserMetaRepository();

  void saveUserMeta(UserMeta userMeta, String uid) async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Saving User Data',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      await userMetaRepository.createUserMeta(uid, userMeta);
      status.value = RxStatus.success();
      Get.back();
      Get.snackbar('Success', 'User data saved successfully');
      // Navigate to home screen or another appropriate screen
      Get.off(() => HomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to save user data. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }
}
