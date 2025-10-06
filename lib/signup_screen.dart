import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/signup_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';
import 'package:task_5_firebase_auth_firestore/utils/string_resources.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupScreenController());
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
                      key: _formKey,
                      child: Column(
                        spacing: Dimen.s16,
                        children: [
                          TextFormField(
                            controller: _emailController,
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
                            controller: _passwordController,
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
                            controller: _confirmPasswordController,
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
                              if (value != _passwordController.text.trim()) {
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
                                if (_formKey.currentState!.validate()) {
                                  controller.signup(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
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
                              : () {
                                  // login with google
                                },
                          icon: Icon(Icons.g_mobiledata, size: Dimen.s40),
                        ),
                        IconButton(
                          onPressed: controller.status.value.isLoading
                              ? null
                              : () {
                                  // login with facebook
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
