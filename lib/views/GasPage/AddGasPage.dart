import 'package:ent5m/controllers/ContactsController.dart';
import 'package:ent5m/controllers/GasController.dart';
import 'package:ent5m/controllers/ResaleController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddGasPage extends StatelessWidget {

  final GasController gasController   = Get.put(GasController());

  AddGasPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Gas Receipt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 20,),
            TextField(
              controller: gasController.cost,
              decoration: const InputDecoration(labelText: 'Cost'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: gasController.mileage,
              decoration: const InputDecoration(labelText: 'Mileage'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:  gasController.unit,
              decoration: const InputDecoration(labelText: 'UNIT'),
            ),
            SizedBox(height: 10),
            TextField(
              controller:  gasController.vin,
              decoration: const InputDecoration(labelText: 'VIN'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:  gasController.plates,
              decoration: const InputDecoration(labelText: 'PLATES'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement the logic to pick the image, upload, and add the shop
                gasController.addGas();
              },
              child: const Text('Add Receipt'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> submitShopDetails() async {
    // Implement the logic here
  }
}
