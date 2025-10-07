import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/home_screen_controller.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget(this.name, {super.key});
  final String name;

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeScreenController>();
    return AlertDialog(
      title: Text('Update Profile'),
      // name must be 3 characters long and not empty
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            value = value?.trim();
            if (value == null || value.isEmpty) {
              return 'Name cannot be empty';
            } else if (value.length < 3) {
              return 'Name must be at least 3 characters long';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              final newName = _nameController.text.trim();
              if (newName != widget.name) {
                controller.updateUserName(newName);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
