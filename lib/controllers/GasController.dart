import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/GasModel.dart';
import 'package:ent5m/models/HomePanelModel.dart';
import 'package:ent5m/models/ResaleModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class GasController extends GetxController {
  TextEditingController cost = TextEditingController();
  TextEditingController vin = TextEditingController();
  TextEditingController plates = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController mileage = TextEditingController();

  clearForm() {
    mileage.clear();
    cost.clear();
    vin.clear();
    unit.clear();
    plates.clear();
  }

  addGas() async {
    if (mileage.text.isNotEmpty && cost.text.isNotEmpty  &&
        (unit.text.isNotEmpty || vin.text.isNotEmpty || plates.text.isNotEmpty))
    {
      try {
        await CollectionRef.path(path: 'gas').add(
            GasModel(
                vin: vin.text,
                unit: unit.text,
                plates: plates.text,
                timeStamp: DateTime.now().toUtc(),
                staffName: 'CurrentUserName',
                cost: cost.text,
                mileage: mileage.text,
                staffId: 'CurrentUser'
            ).toJson()
        );

        await CollectionRef.path(path: 'notes').add(
            HomePanelModel(
              timeStamp: DateTime.now().toUtc(),
              type: "gas",
              isPinned: false,
              vin: vin.text,
              unit: unit.text,
              plates: plates.text,
              cost: cost.text,
              mileage: mileage.text,
              staffId: 'CurrentUser',
              userName: 'staffName'
            ).toJson());


        Get.back();
        Fluttertoast.showToast(msg: 'Gas receipt Added');
        clearForm();
      } catch (e) {
        print(e);
      }
    } else {
      if(cost.text.isEmpty && mileage.text.isEmpty) {
        Fluttertoast.showToast(msg: 'Fill up cost & mileage');
      }
      Fluttertoast.showToast(msg: 'unit, vin, plates, fil at least 1',toastLength: Toast.LENGTH_LONG, timeInSecForIosWeb: 4);
    }
  }
}
