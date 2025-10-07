import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/data/user_meta_repository.dart';
import 'package:task_5_firebase_auth_firestore/models/user_meta.dart';
import 'package:task_5_firebase_auth_firestore/route/route_names.dart';

class HomeScreenController extends GetxController {
  final AuthRepository authRepository;
  final UserMetaRepository userMetaRepository;

  final Rx<RxStatus> status = RxStatus.loading().obs;
  final Rx<UserMeta?> userMeta = Rx<UserMeta?>(null);

  HomeScreenController()
    : authRepository = AuthRepository(),
      userMetaRepository = UserMetaRepository() {
    loadUserMeta();
  }

  void loadUserMeta() async {
    try {
      final uid = authRepository.currentUser?.uid;
      if (uid == null) {
        Get.offNamed(RouteNames.login);
        return;
      }
      userMeta.value = await userMetaRepository.getUserMeta(uid);
      status.value = RxStatus.success();
    } catch (e) {
      log('Error in loadUserMeta: $e');
      status.value = RxStatus.error(e.toString());
    }
  }

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
      Get.offNamed(RouteNames.login);
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
      final uid = authRepository.currentUser?.uid;
      await authRepository.deleteAccount();
      await userMetaRepository.deleteUserMeta(uid ?? '');
      status.value = RxStatus.success();
      Get.back();
      Get.offNamed(RouteNames.login);
      Get.snackbar('Success', 'Account deleted successfully');
    } catch (e) {
      Get.back();
      log('Error in deleteAccount: $e');
      Get.snackbar('Error', 'Account deletion failed. ${e.toString()}');
      status.value = RxStatus.error(e.toString());
    }
  }

  void updateUserName(String newName) async {
    try {
      status.value = RxStatus.loading();
      final uid = authRepository.currentUser?.uid;
      if (uid == null) {
        Get.offNamed(RouteNames.login);
        return;
      }
      await userMetaRepository.updateUserName(uid, newName);
      // Update local userMeta
      userMeta.value = userMeta.value?.copyWith(name: newName);
      status.value = RxStatus.success();
      Get.snackbar('Success', 'Name updated successfully');
    } catch (e) {
      log('Error in updateUserName: $e');
      Get.snackbar('Error', 'Name update failed. ${e.toString()}');
      status.value = RxStatus.error(e.toString());
    }
  }
}
