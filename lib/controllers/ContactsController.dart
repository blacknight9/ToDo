import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/NotesModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ContactsController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController desc = TextEditingController();

  clearForm() {
    name.clear();
    phoneNumber.clear();
    desc.clear();
  }

  addContact() async {
    String docId = getRandomId2(16);
    if (name.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty &&
        desc.text.isNotEmpty) {
      try {
        await CollectionRef.path(path: 'contacts').doc(phoneNumber.text).set({
          "name": name.text,
          "phoneNumber": formatPhoneNumber(phoneNumber.text),
          "desc": desc.text,
        });

        await CollectionRef.path(path: 'notes').doc(docId).set(
            NotesModel(
                timeStamp: DateTime.now().toUtc(),
                type: "contact",
                name: name.text,
                phoneNumber: formatPhoneNumber(phoneNumber.text),
                desc: desc.text,
              isPinned: false,
              docId: docId,
            ).toJson());


        Get.back();
        Fluttertoast.showToast(msg: 'Contact Added');
        clearForm();
      } catch (e) {
        print(e);
      }
    } else {
      Fluttertoast.showToast(msg: 'Fill up all fields');
    }
  }
}
