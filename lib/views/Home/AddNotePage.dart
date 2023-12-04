import 'package:ent5m/views/Widgets/PasswordVerification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/HomeController.dart';
import '../../controllers/SignUpLoginController.dart';

class AddNotePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  SignUpLoginController signUpLoginController = Get.put(SignUpLoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Note'),
      leading: IconButton(
          onPressed: ()=> Get.back(), icon: const Icon(Icons.clear),
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                maxLength: 15,
                onChanged: (value) => homeController.title.value = value,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                onChanged: (value) => homeController.message.value = value,
                decoration: const InputDecoration(labelText: 'Message'),
                maxLines: null, // Makes it expandable
              ),
              const SizedBox(height: 8.0),
              Obx(() => CheckboxListTile(
                title: const Text('Pin Note on Top'),
                value: homeController.isPinned.value,
                onChanged: (bool? newValue) {
                  homeController.isPinned.value = newValue!;
                },
              )),
              ElevatedButton(
                onPressed: () {
                  Get.bottomSheet(PasswordVerification(onPressed: () {
                   signUpLoginController.verifyPassword(addNoteFn: homeController.addNote);

                  },));
                  // homeController.addNote(context);
                },
                child: const Text('Save Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
