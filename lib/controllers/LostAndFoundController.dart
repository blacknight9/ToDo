import 'dart:async';

import 'package:ent5m/models/LostAndFoundModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/StaffModel.dart';

class LostAndFoundController extends GetxController {
  Rx<DateTime?> date = Rx<DateTime?>(null);
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final RxList<StaffModel> currentUserData = <StaffModel>[].obs;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationFoundController = TextEditingController();
  final TextEditingController foundByController = TextEditingController();
  final TextEditingController tagIdController = TextEditingController();
  final TextEditingController uniIdController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUserData();
    date.value = DateTime.now();
    if (currentUserData.isEmpty) {
      Timer(const Duration(seconds: 1), () {
        foundByController.text = currentUserData.first.name;
      });
    } else {
      foundByController.text = currentUserData.first.name;
    }
  }

  clearForm() {
    descriptionController.clear();
    locationFoundController.clear();
    foundByController.clear();
    tagIdController.clear();
    date.value = null;
  }

  getCurrentUserData() async {
    await CollectionRef.path(path: 'staff')
        .where('uid', isEqualTo: currentUser)
        .get()
        .then((event) {
      for (var x in event.docs) {
        var data = x.data() as Map<String, dynamic>;
        StaffModel staffModel = StaffModel.fromJson(data);

        currentUserData.add(staffModel);
      }
    });
  }

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      date.value = picked;
      // Trigger UI updates or notify listeners if needed
    }
  }

  addLostAndFound({required GlobalKey<FormState> key}) async {
    if (key.currentState!.validate() && date.value != null) {
      try {
        await CollectionRef.path(path: 'LAF')
            .doc(tagIdController.text)
            .set(LostAndFoundModel(
              description: descriptionController.text,
              locationFound: locationFoundController.text,
              foundBy: foundByController.text,
              unit: uniIdController.text,
              uid: currentUser,
              eid: currentUserData.first.eid,
              timeStamp: DateTime.now().toUtc(),
              dateFound: date.value!,
              isClosed: false,
            ).toJson());
        clearForm();
        Get.back();
      } catch (e) {
        print(e);
      }
    }
  }
}
