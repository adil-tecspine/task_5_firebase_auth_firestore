import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/signup_screen.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';
import 'package:task_5_firebase_auth_firestore/utils/string_resources.dart';

import 'controller/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginScreenController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimen.s16),
          child: Center(
            child: SingleChildScrollView(
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Dimen.s16,
                  children: [
                    // Login With Email
                    Text(
                      StringResources.loginWithEmail,
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
                                  controller.loginWithEmailPassword(
                                    controller.emailController.text.trim(),
                                    controller.passwordController.text.trim(),
                                  );
                                }
                              },
                        child: const Text(StringResources.login),
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: controller.status.value.isLoading
                              ? null
                              : () => controller.loginWithGoogle(),
                          icon: Icon(Icons.g_mobiledata, size: Dimen.s40),
                        ),
                        IconButton(
                          onPressed: controller.status.value.isLoading
                              ? null
                              : () => controller.loginWithFacebook(),
                          icon: Icon(Icons.facebook, size: Dimen.s40),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: controller.status.value.isLoading
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                      child: const Text(
                        StringResources.signUpPrompt,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
