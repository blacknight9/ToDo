import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/HomePanelModel.dart';
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

  clearForm() {
    carDesc.clear();
    vin.clear();
    unit.clear();
    plates.clear();
  }

  addResale() async {
    if (carDesc.text.isNotEmpty &&
        (unit.text.isNotEmpty || vin.text.isNotEmpty || plates.text.isNotEmpty))
    {
      try {
        await CollectionRef.path(path: 'resale').add(
          ResaleModel(carDesc: carDesc.text,
              vin: vin.text,
              unit: unit.text,
              plates: plates.text,
              timeStamp: DateTime.now()
          ).toJson()
        );

        await CollectionRef.path(path: 'notes').add(
            HomePanelModel(
              timeStamp: DateTime.now().toUtc(),
              type: "resale",
              isPinned: false,
              carDesc: carDesc.text,
              vin: vin.text,
              unit: unit.text,
              plates: plates.text,
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
