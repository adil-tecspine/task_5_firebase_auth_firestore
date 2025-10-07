import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_5_firebase_auth_firestore/controller/home_screen_controller.dart';
import 'package:task_5_firebase_auth_firestore/update_profile_widget.dart';
import 'package:task_5_firebase_auth_firestore/utils/dimen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.all(Dimen.s16),
        child: Center(
          child: Obx(() {
            if (controller.status.value.isLoading) {
              return const CircularProgressIndicator();
            } else if (controller.userMeta.value == null) {
              return const Text('No user data available');
            }
            return Column(
              spacing: Dimen.s20,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: ListTile(
                    title: Text(controller.userMeta.value?.name ?? 'No Name'),
                    subtitle: Text(
                      controller.userMeta.value?.email ?? 'No Email',
                    ),
                    trailing: Icon(
                      controller.userMeta.value?.loginTypeIcon ??
                          Icons.account_circle,
                    ),

                    // tapping on the listitle opens up a dilaog with the name field to update the name of the person
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => UpdateProfileWidget(
                        controller.userMeta.value?.name ?? 'No Name',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    child: const Text('Logout'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.deleteAccount();
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Account'),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
