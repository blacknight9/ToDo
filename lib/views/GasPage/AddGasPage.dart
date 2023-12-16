import 'package:ent5m/controllers/ContactsController.dart';
import 'package:ent5m/controllers/GasController.dart';
import 'package:ent5m/controllers/HomeController.dart';
import 'package:ent5m/controllers/ResaleController.dart';
import 'package:ent5m/views/Widgets/PasswordVerification.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controllers/SignUpLoginController.dart';

class AddGasPage extends StatelessWidget {
  final GasController gasController = Get.put(GasController());
  final HomeController homeController = Get.put(HomeController());
  SignUpLoginController signUpLoginController =
      Get.put(SignUpLoginController());

  AddGasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gas Receipt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: gasController.cost,
                decoration: const InputDecoration(labelText: 'Cost'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gasController.mileage,
                decoration: const InputDecoration(labelText: 'Mileage'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gasController.unit,
                decoration: const InputDecoration(labelText: 'UNIT'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gasController.vin,
                decoration: const InputDecoration(labelText: 'VIN'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gasController.plates,
                decoration: const InputDecoration(labelText: 'PLATES'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Implement the logic to pick the image, upload, and add the shop
          
                  if (gasController.mileage.text.isNotEmpty &&
                      gasController.cost.text.isNotEmpty &&
                      (gasController.unit.text.isNotEmpty ||
                          gasController.vin.text.isNotEmpty ||
                          gasController.plates.text.isNotEmpty)) {
                    await Get.bottomSheet(
                      PasswordVerification(onPressed: () async {
                        await signUpLoginController.verifyPassword(
                          fn: () async => gasController.addGas(
                              staffId: homeController.currentUserData.first.eid,
                              staffName:
                                  homeController.currentUserData.first.name),
                        );
                      }),
                    );
                  } else {
                    if (gasController.cost.text.isEmpty &&
                        gasController.mileage.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Fill up cost & mileage');
                    }
                    Fluttertoast.showToast(
                        msg: 'unit, vin, plates, fil at least 1',
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 4);
                  }
                },
                child: const Text('Add Receipt'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitShopDetails() async {
    // Implement the logic here
  }
}
