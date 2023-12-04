import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/HomePanelModel.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../views/Widgets/PasswordVerification.dart';

class HomeController extends GetxController {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
  final RxList<StaffModel> currentUserData = <StaffModel>[].obs;
  var title = ''.obs;
  var message = ''.obs;
  var isPinned = false.obs;
  RxInt so = 0.obs;
  RxInt cs = 0.obs;
  RxDouble addRev = 0.0.obs;
  RxInt hotAlert = 0.obs;
  RxInt sqi = 0.obs;
  RxBool isSo = false.obs;
  final TextEditingController soController = TextEditingController();
  final TextEditingController csController = TextEditingController();
  final TextEditingController addRevController = TextEditingController();
  final TextEditingController hotAlertController = TextEditingController();
  final TextEditingController sqiController = TextEditingController();

  late Stream<QuerySnapshot> pinnedStream;
  late Stream<QuerySnapshot> notesStream;

  @override
  onInit() {
    super.onInit();
    getCurrentUserData ();
    getHomePanelData();
    pinnedStream = FirebaseFirestore.instance
        .collection('notes')
        .orderBy('timeStamp', descending: true)
        .limit(1)
        .snapshots();
    notesStream = FirebaseFirestore.instance
        .collection('notes')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }
  
  getCurrentUserData () {

    CollectionRef.path(path: 'staff').where('uid',isEqualTo: currentUser).snapshots().listen((event)  {
      for(var x in event.docs) {
        var data = x.data() as Map<String,dynamic>;
        StaffModel staffModel = StaffModel.fromJson(data);

        currentUserData.add(staffModel);
        

      }

    });
  }
  void updateAvailability (value) async{
    await CollectionRef.path(path: 'homePanel').doc('homePanel').update({'isSo' : value});
  }

  Future<void> updateHomePanelData() async {
    try {
      await FirebaseFirestore.instance
          .collection('homePanel')
          .doc('homePanel')
          .update({
        'so': int.parse(soController.text),
        'cs': int.parse(csController.text),
        'addRev': double.parse(addRevController.text),
        'hotAlert': int.parse(hotAlertController.text),
        'sqi': int.parse(sqiController.text),
      });
      Fluttertoast.showToast(
          msg: 'Success, Data updated successfully',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error, Failed to update data',
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 3);
      print(e);
    }
  }

  void getHomePanelData() {
    CollectionRef.path(path: 'homePanel')
        .doc('homePanel')
        .snapshots()
        .listen((event) {
      var data = event.data() as Map<String, dynamic>;
      cs.value = data['cs'];
      addRev.value = data['addRev'];
      sqi.value = data['sqi'];
      so.value = data['so'];
      hotAlert.value = data['hotAlert'];
      isSo.value = data['isSo'];
    });
  }

  Future<void> addNote() async {
    try {
      CollectionReference notes =
          FirebaseFirestore.instance.collection('notes');

      // If the new note is pinned, unpin all other notes first
      if (message.value.isEmpty || title.value.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Fields can\'t be empty',
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 3);
        return;
      } else {

          if (isPinned.value == true) {
            // Get all pinned notes
            QuerySnapshot querySnapshot =
                await notes.where('isPinned', isEqualTo: true).get();

            // Iterate and update each pinned note to be unpinned
            for (var doc in querySnapshot.docs) {
              await notes.doc(doc.id).update({'isPinned': false});
            }
          }

          // Add the new note
          await notes.add(HomePanelModel(
                  title: title.value,
                  message: message.value,
                  isPinned: isPinned.value,
                  timeStamp: DateTime.now().toUtc(),
                  dp: '',
                  type: 'note',
                  userName: currentUserData.first.name)
              .toJson());

          // Reset fields after saving
          title.value = '';
          message.value = '';
          isPinned.value = false;
          Get.back();

      }
    } catch (e) {
      print(e);
    }
  }
}
