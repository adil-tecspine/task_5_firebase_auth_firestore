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

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegistrationScreenController>();
    final arguments = Get.arguments;
    final User user = arguments['user'] as User;
    final LoginType loginType = arguments['loginType'] as LoginType;

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
                    key: controller.formKey,
                    child: Column(
                      spacing: Dimen.s16,
                      children: [
                        TextFormField(
                          controller: controller.nameController,
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
                        if (controller.formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          final userMeta = UserMeta(
                            email: user.email!,
                            name: controller.nameController.text.trim(),
                            loginType: loginType,
                          );
                          log(userMeta.toString());
                          controller.saveUserMeta(userMeta, user.uid);
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
