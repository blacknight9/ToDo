import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/FleetPage/Reservations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/AddVanModel.dart';
import '../models/ResModel.dart';
import '../models/StaffModel.dart';

class FleetController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final RxList<StaffModel> currentUserData = <StaffModel>[].obs;
  final RxList<ResModel> resSearchResults = <ResModel>[].obs;

  RxString selectedPacker= 'test1'.obs;
  var vansList = <AddVanModel>[].obs;
  var selectedVan = Rxn<AddVanModel>();
  RxList<ResModel> reservations = <ResModel>[].obs; // Using RxList for reactivity
  final eventNameController = TextEditingController();
  final phoneController = TextEditingController();
  final unitController = TextEditingController();
  final sizeController = TextEditingController();
  final noteController = TextEditingController();
  final resNumController = TextEditingController();
  final packMakeController = TextEditingController();
  final packModelController = TextEditingController();
  final packYearController = TextEditingController();
  final packUnitController = TextEditingController();
  final packVinController = TextEditingController();
  final packPlatesController = TextEditingController();
  final packSeatsController = TextEditingController();



  // Variables for color picker, date, and time
  // var currentColor = Rx<Color>(Colors.blue[500]!);
  Rx<Color> currentColor = const Color(0xff443a49).obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  Rx<DateTime?> timeOfPickup = Rx<DateTime?>(null);
  RxBool isAllDay = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchVans();
    getCurrentUserData ();
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


  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      // Use the pickedTime here. It's a TimeOfDay object.

      // If you need a DateTime object:
      final now = DateTime.now();
      final selectedDateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      timeOfPickup.value = selectedDateTime;
      print('Selected DateTime: $selectedDateTime');  // Prints the selected date with time.
    }
  }


  searchRes() async{
    if(resNumController.text.isNotEmpty) {
      try{
      var getRes =  await CollectionRef.path(path: 'reservations').doc(resNumController.text).get();
      var data = getRes.data() as Map<String,dynamic>;
      ResModel resModel = ResModel.fromJson(data);
      resSearchResults.add(resModel);
      } catch (e) {
        print(e);
      }
    }
  }


  getCurrentUserData () async{

    await CollectionRef.path(path: 'staff').where('uid',isEqualTo: currentUser).get().then((event)  {
      for(var x in event.docs) {
        var data = x.data() as Map<String,dynamic>;
        StaffModel staffModel = StaffModel.fromJson(data);

        currentUserData.add(staffModel);


      }

    });
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

  void addPacker(GlobalKey<FormState> key) async {
    if(key.currentState!.validate() && packUnitController.text.isNotEmpty) {
      await CollectionRef.path(path: 'packers').doc(packUnitController.text).get().then((value) async {
        if (value.exists) {
          print('already in list');
        } else {
          try {
           CollectionRef.path(path: 'packers').doc(packUnitController.text).set(

               AddVanModel(
                 unitNumber: packUnitController.text,
                 vin: packVinController.text,
                 plates: packPlatesController.text,
                 seats: packSeatsController.text,
                 make: packMakeController.text,
                 model: packModelController.text,
                 year: packYearController.text,

               ).toMap(),
           );
            Get.back();
          } catch (e) {
            print(e);
          }
        }
      });
    } else {
      Fluttertoast.showToast(msg: 'fill up the form',toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 3);
    }

  }

  getDataSource() {
    CollectionRef.path(path: 'reservations').snapshots().listen((event) {
      reservations.clear();
      for (var x in event.docs) {
        var data = x.data() as Map<String, dynamic>;
        ResModel resModel = ResModel.fromJson(data);

        reservations.add(resModel);
        update();
      }
    });
  }

  clearResForm () {
    fromDate.value = null;
    toDate.value = null;
    eventNameController.clear();
    unitController.clear();
    sizeController.clear();
    noteController.clear();
  }

  Future<void> addRes({required GlobalKey<FormState> key, ResModel? resModel, required bool isEdit}) async {
    String? resNumber = getRandomId2(8);
    if(key.currentState!.validate() && fromDate.value !=null && toDate.value != null && timeOfPickup.value != null) {
      try{

        isEdit == false ?

        await CollectionRef.path(path: 'reservations').doc(resNumber).set(
            ResModel(
              resNumber: resNumber,
                eventName: eventNameController.text,
                from: fromDate.value!,
                to: toDate.value!,
                background: currentColor.value,
                isAllDay:  true,
                unit: selectedVan.value != null ? selectedVan.value!.unitNumber : unitController.text,
                size: selectedVan.value != null ? selectedVan.value!.seats : sizeController.text,
                note: noteController.text,
                uid: currentUser,
              timeStamp: DateTime.now().toUtc(),
              staffId: currentUserData.first.eid,
              staffName: currentUserData.first.name,
              timeOfPickup: timeOfPickup.value!,
              phoneNumber: phoneController.text ,
            ).toJson()
        )  :
        await CollectionRef.path(path: 'reservations').doc(resModel!.resNumber).update(
            ResModel(
              resNumber: resModel.resNumber,
              eventName: eventNameController.text,
              from: fromDate.value!,
              to: toDate.value!,
              background: currentColor.value,
              isAllDay:  true,
              unit: selectedVan.value != null ? selectedVan.value!.unitNumber : unitController.text,
              size: selectedVan.value != null ? selectedVan.value!.seats : sizeController.text,
              note: noteController.text,
              uid: currentUser,
              timeStamp: DateTime.now().toUtc(),
              staffId: currentUserData.first.eid,
              staffName: currentUserData.first.name,
              timeOfPickup: timeOfPickup.value!,
              phoneNumber: phoneController.text ,
            ).toJson()
        );


        clearResForm();
        isEdit == false ?Get.back() : Get.off(()=> const Reservations());
      } catch (e) {
        print(e);
      }
    } else {
      Fluttertoast.showToast(msg: 'Fill Up the form',timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
    }

  }
}
