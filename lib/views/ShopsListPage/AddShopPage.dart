import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/views/Widgets/PasswordVerification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ShopsController.dart';
import 'dart:io';

class AddShopPage extends StatelessWidget {

  final ShopsController shopsController = Get.put(ShopsController());

  AddShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Shop'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 20,),
            TextField(
              controller: shopsController.shopNameController,
              decoration: const InputDecoration(labelText: 'Shop Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:  shopsController.addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLength: 10,
              controller:  shopsController.phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement the logic to pick the image, upload, and add the shop
                Get.bottomSheet(PasswordVerification(onPressed: shopsController.addShop));
              },
              child: const Text('Add Shop'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitShopDetails() async {
    // Implement the logic here
  }
}
