import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/user_meta_repository.dart';
import 'package:task_5_firebase_auth_firestore/models/user_meta.dart';
import 'package:task_5_firebase_auth_firestore/route/route_names.dart';

class RegistrationScreenController extends GetxController {
  final UserMetaRepository userMetaRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  TextEditingController get nameController => _nameController;
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onInit() {
    super.onInit();
    _nameController = TextEditingController();
  }

  @override
  void onClose() {
    _nameController.dispose();
    super.onClose();
  }

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
      Get.offNamed(RouteNames.home);
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to save user data. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }
}
