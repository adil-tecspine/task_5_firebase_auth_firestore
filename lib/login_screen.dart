import 'package:flutter/material.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';
import 'package:task_5_firebase_auth_firestore/utils/string_resources.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processing Data')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Validation Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimen.s16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: Dimen.s16,
                children: [
                  // Login With Email
                  Text(
                    StringResources.loginWithEmail,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: Dimen.s16,
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: StringResources.emailLabel,
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          decoration: const InputDecoration(
                            labelText: StringResources.passwordLabel,
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      onPressed: onSubmit,
                      child: const Text(StringResources.login),
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          // login with google
                        },
                        icon: Icon(Icons.g_mobiledata, size: Dimen.s40),
                      ),
                      IconButton(
                        onPressed: () {
                          // login with facebook
                        },
                        icon: Icon(Icons.facebook, size: Dimen.s40),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // navigate to sign up screen
                    },
                    child: const Text(
                      StringResources.signUpPrompt,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
