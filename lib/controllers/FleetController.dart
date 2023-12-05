import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/AddVanModel.dart';
import '../models/ResModel.dart';

class FleetController extends GetxController {
  RxString selectedPacker= 'test1'.obs;
  var vansList = <AddVanModel>[].obs;
  var selectedVan = Rxn<AddVanModel>();
  RxList<ResModel> reservations = <ResModel>[].obs; // Using RxList for reactivity
  final eventNameController = TextEditingController();
  final unitController = TextEditingController();
  final sizeController = TextEditingController();
  final noteController = TextEditingController();

  // Variables for color picker, date, and time
  // var currentColor = Rx<Color>(Colors.blue[500]!);
  Rx<Color> currentColor = const Color(0xff443a49).obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  RxBool isAllDay = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchVans();
    // addAppointment();
    getDataSource();
  }

  @override
  void dispose() {
    super.dispose();
    eventNameController.dispose();
    unitController.dispose();
    sizeController.dispose();
    noteController.dispose();
  }
  void fetchVans() async {
    FirebaseFirestore.instance.collection('packers').snapshots().listen((snapshot) {
      var vans = snapshot.docs.map((doc) => AddVanModel.fromMap(doc.data())).toList();
      vansList.assignAll(vans);
    });
  }
  // Method to handle color changes
  void changeColor(Color color) {
    currentColor.value = color;
    // Trigger any necessary UI updates or notify listeners if needed
  }

  // Method to pick dates
  Future<void> pickDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? fromDate.value : toDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        fromDate.value = picked;
      } else {
        toDate.value = picked;
      }
      // Trigger UI updates or notify listeners if needed
    }
  }

  // Method to handle the All Day switch
  void setAllDay(bool value) {
    isAllDay.value = value;
    // Trigger any necessary UI updates or notify listeners if needed
  }

  void addPacker({required String unitNumber}) async {
    await CollectionRef.path(path: 'packers').doc(unitNumber).get().then((value) async {
      if (value.exists) {
        print('already in list');
      } else {
        try {
          await CollectionRef.path(path: 'packers').doc(unitNumber).set({
            'unitNumber': unitNumber,
            'vin': 'VR123456',
            'make': 'ford',
            'model': 'TRANSIT® VAN',
            'year': 2023,
            'seats': 15,
            'photo':
                'https://www.vdm.ford.com/content/dam/vdm_ford/live/en_us/ford/nameplate/transitvanwagon/2023/collections/3_2/TT_offroad_2160px-X-926px.jpg/jcr:content/renditions/cq5dam.web.2160.2160.jpeg'
          });
        } catch (e) {
          print(e);
        }
      }
    });
  }

  getDataSource() {
    CollectionRef.path(path: 'reservations').snapshots().listen((event) {
      reservations.clear();
      for (var x in event.docs) {
        var data = x.data() as Map<String, dynamic>;
        print(data);

        ResModel resModel = ResModel.fromJson(data);

        reservations.add(resModel);
        update();
      }
    });
  }

  Future<void> addAppointment() async {
 try{
   await CollectionRef.path(path: 'reservations').add(
       ResModel(

           eventName: eventNameController.text,
           from: fromDate.value!,
           to: toDate.value!,
           background: currentColor.value,
           isAllDay:  isAllDay.value,
           unit: unitController.text,
           size: sizeController.text,
           note: noteController.text).toJson()
   );
 } catch (e) {
   print(e);
 }
  }
}
