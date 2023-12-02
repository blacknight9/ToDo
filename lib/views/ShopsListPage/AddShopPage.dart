import 'package:ent5m/constants/Colors.dart';
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
        title: Text('Add Shop'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Obx(() => shopsController.selectedImage.value != null || shopsController.selectedImageWeb.value != null
                ? CircleAvatar(
              backgroundImage: kIsWeb
                  ? NetworkImage(shopsController.selectedImageWeb.value!)
                  : FileImage(shopsController.selectedImage.value!) as ImageProvider,
              radius: 40,
            )
                : IconButton(
              onPressed: () => shopsController.pickImage(),
              icon: const Icon(Icons.add_circle, color: myAppBar, size: 50),
            ),
            ),


            SizedBox(height: 20,),
            TextField(
              controller: shopsController.shopNameController,
              decoration: InputDecoration(labelText: 'Shop Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller:  shopsController.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 10),
            TextField(
              controller:  shopsController.phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement the logic to pick the image, upload, and add the shop
                shopsController.addShop();
              },
              child: Text('Add Shop'),
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
