import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/models/login_type_enum.dart';
import 'package:task_5_firebase_auth_firestore/models/user_meta.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';
import 'package:task_5_firebase_auth_firestore/utils/string_resources.dart';

import 'controller/registration_screen_controller.dart'
    show RegistrationScreenController;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen(this.user, this.loginType, {super.key});

  final User user;
  final LoginType loginType;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistrationScreenController());
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
                  // Enter Name
                  Text(
                    StringResources.enterName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: Dimen.s16,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: StringResources.nameLabel,
                            border: OutlineInputBorder(),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          autofillHints: const [AutofillHints.name],
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          validator: (value) {
                            value = value?.trim();
                            if (value == null || value.isEmpty) {
                              return StringResources.enterName;
                            }
                            if (value.length < 3) {
                              return StringResources.nameTooShort;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          final userMeta = UserMeta(
                            email: widget.user.email!,
                            name: _nameController.text.trim(),
                            loginType: widget.loginType,
                          );
                          log(userMeta.toString());
                          controller.saveUserMeta(userMeta, widget.user.uid);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Validation Failed')),
                          );
                        }
                      },
                      child: const Text(StringResources.continueButton),
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
