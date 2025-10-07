import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/signup_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';
import 'package:task_5_firebase_auth_firestore/utils/string_resources.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SignupScreenController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimen.s16),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Dimen.s16,
                  children: [
                    // Sign Up With Email
                    Text(
                      StringResources.signUpWithEmail,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        spacing: Dimen.s16,
                        children: [
                          TextFormField(
                            controller: controller.emailController,
                            enabled: !controller.status.value.isLoading,
                            decoration: const InputDecoration(
                              labelText: StringResources.emailLabel,
                              border: OutlineInputBorder(),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              // regex for email validation
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),

                          // add validation to password field - not empty, at least 6 characters long
                          TextFormField(
                            controller: controller.passwordController,
                            enabled: !controller.status.value.isLoading,
                            decoration: const InputDecoration(
                              labelText: StringResources.passwordLabel,
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),

                          // add validation to confirm password field - not empty, matches password field
                          TextFormField(
                            controller: controller.confirmPasswordController,
                            enabled: !controller.status.value.isLoading,
                            decoration: const InputDecoration(
                              labelText: StringResources.confirmPasswordLabel,
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              value = value?.trim();
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value !=
                                  controller.passwordController.text.trim()) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    // elevated button for login that strectches the full width of the screen
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.status.value.isLoading
                            ? null
                            : () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.signupWithEmailPassword(
                                    controller.emailController.text.trim(),
                                    controller.passwordController.text.trim(),
                                  );
                                }
                              },
                        child: const Text(StringResources.signUp),
                      ),
                    ),
                    const Divider(),
                    Text('Or sign up with'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: controller.status.value.isLoading
                              ? null
                              : () => controller.signupWithGoogle(),
                          icon: Icon(Icons.g_mobiledata, size: Dimen.s40),
                        ),
                        IconButton(
                          onPressed: controller.status.value.isLoading
                              ? null
                              : () {
                                  controller.signupWithFacebook();
                                },
                          icon: Icon(Icons.facebook, size: Dimen.s40),
                        ),
                      ],
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        StringResources.alreadyHaveAccountPrompt,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
