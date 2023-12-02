
import 'dart:io';

import 'package:ent5m/models/ShopsListModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopsController extends GetxController {
  var selectedImage = Rxn<File?>();
  var selectedImageWeb = Rxn<String>();
  String selectedImageUrl = '';
  TextEditingController shopNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (kIsWeb) {
        // For web, store the image URL directly
        selectedImageWeb.value = image.path; // Path is a Blob URL on the web
      } else {
        // For mobile, convert to File and proceed
        File imageFile = File(image.path);
        String imageUrl = await uploadLogo(imageFile);
        selectedImage.value = imageFile;
        selectedImageUrl = imageUrl;
      }
    }
  }

  Future<String> uploadLogo(File imageFile) async {
    // Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

    // Create a unique file name for the image
    String fileName = 'shops/shop_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Create a reference to the file location in storage
    final fileRef = storageRef.child(fileName);

    try {
      // Upload the file to the path in storage
      await fileRef.putFile(imageFile);

      // Once the file is uploaded, get the URL
      String downloadUrl = await fileRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      // Handle any errors during upload
      print(e);
      return '';
    }
  }



  Future<void> openMap(String address) async {
    // Properly create a Uri object from the address string
    var encoded = Uri.encodeFull(address);
    Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');

    try {
      Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encoded');
      if (await canLaunchUrl(googleUrl)) {
        await launchUrl(googleUrl);
      } else {
        print('Could not launch $googleUrl');
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }


  Future<void> makePhoneCall(String phoneNumber) async {
    // Properly create a Uri object from the phone number string
    Uri telUrl = Uri.parse('tel:$phoneNumber');

    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl);
    } else {
      throw 'Could not launch the phone dialer.';
    }
  }



  Future<void> addShop() async {
    // Use the imageUrl in your Shop model
    ShopsListModel newShop = ShopsListModel(
        shopName: shopNameController.text,
        address: addressController.text,
        phoneNumber: phoneNumberController.text,
        logo: selectedImageUrl.isNotEmpty ? selectedImageUrl :  selectedImageWeb.value!);
    if (selectedImageUrl.isNotEmpty || selectedImageWeb.value != null) {
      String docId = phoneNumberController.text.replaceAll(RegExp(r'\D'), '');
      await CollectionRef.path(path: 'shopsList')
          .doc(docId)
          .set(
        newShop.toJson(),
      );
    } else {
      Fluttertoast.showToast(msg: 'SelectImage');
      return ;
    }

  }

  String formatPhoneNumber(String number) {
    // Remove any non-digit characters from the input
    String digitsOnly = number.replaceAll(RegExp(r'\D'), '');

    // Check if the string contains exactly 10 digits
    if (digitsOnly.length == 10) {
      // Format the string as (XXX) XXX-XXXX
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else {
      // Return the original string or handle the error as needed
      return number;
    }
  }


}
