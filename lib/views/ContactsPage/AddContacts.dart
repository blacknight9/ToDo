import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/controllers/ContactsController.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddContacts extends StatelessWidget {

  final ContactsController contactsController  = Get.put(ContactsController());

  AddContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20,),
              TextField(
                controller: contactsController.name,
                decoration: const InputDecoration(labelText: 'Contact name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller:  contactsController.desc,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 10),
              TextField(
                controller:  contactsController.phoneNumber,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Implement the logic to pick the image, upload, and add the shop
                  contactsController.addContact();
                },
                child: const Text('Add Shop'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitShopDetails() async {
    // Implement the logic here
  }
}
