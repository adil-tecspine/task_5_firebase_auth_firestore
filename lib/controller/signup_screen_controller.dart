import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/data/auth_repository.dart';
import 'package:task_5_firebase_auth_firestore/models/login_type_enum.dart';
import 'package:task_5_firebase_auth_firestore/route/route_names.dart';

class SignupScreenController extends GetxController {
  final AuthRepository authRepository;

  final Rx<RxStatus> status = RxStatus.empty().obs;

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.onClose();
  }

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
        Get.toNamed(RouteNames.register, arguments: [user, LoginType.email]);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Signup failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }

  // signup with google
  void signupWithGoogle() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Signing Up',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.signInWithGoogle();

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Signup failed.');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Your account has been created successfully');
        Get.toNamed(RouteNames.register, arguments: [user, LoginType.google]);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Signup failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }

  // signup with facebook
  void signupWithFacebook() async {
    try {
      status.value = RxStatus.loading();
      Get.defaultDialog(
        title: 'Signing Up',
        content: const CircularProgressIndicator(),
        barrierDismissible: false,
      );
      final user = await authRepository.signInWithFacebook();

      if (user == null) {
        status.value = RxStatus.error('User is null');
        Get.back();
        Get.snackbar('Error', 'Signup failed.');
        return;
      } else {
        status.value = RxStatus.success();
        Get.back();
        Get.snackbar('Success', 'Your account has been created successfully');
        Get.toNamed(RouteNames.register, arguments: [user, LoginType.facebook]);
      }
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Signup failed. ${e.toString()}');

      status.value = RxStatus.error(e.toString());
    }
  }
}
