import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/controllers/HomeController.dart';
import 'package:ent5m/models/NotesModel.dart';
import 'package:ent5m/models/ResaleModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ResaleController extends GetxController {
  TextEditingController carDesc = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController vin = TextEditingController();
  TextEditingController plates = TextEditingController();
  late HomeController? homeController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeController = Get.put(HomeController());
  }


  clearForm() {
    carDesc.clear();
    vin.clear();
    unit.clear();
    plates.clear();
  }

  addResale() async {
    String docId = getRandomId2(16);
    if (carDesc.text.isNotEmpty &&
        (unit.text.isNotEmpty || vin.text.isNotEmpty || plates.text.isNotEmpty))
    {
      try {
        await CollectionRef.path(path: 'resale').add(
          ResaleModel(carDesc: carDesc.text,
              docId: docId,
              vin: vin.text,
              unit: unit.text,
              plates: plates.text,
              staffId: homeController!.currentUserData.first.eid,
              timeStamp: DateTime.now()
          ).toJson()
        );

        await CollectionRef.path(path: 'notes').doc(docId).set(
            NotesModel(
              timeStamp: DateTime.now().toUtc(),
              type: "resale",
              isPinned: false,
              carDesc: carDesc.text,
              staffId: homeController!.currentUserData.first.eid,
              vin: vin.text,
              unit: unit.text,
              plates: plates.text,
              docId: docId
            ).toJson());


        Get.back();
        Fluttertoast.showToast(msg: 'Resale Added');
        clearForm();
      } catch (e) {
        print(e);
      }
    } else {
      if(carDesc.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Fill up description');
      }
      Fluttertoast.showToast(msg: 'unit, vin, plates, fil at least 1',toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 4);
    }
  }
}
