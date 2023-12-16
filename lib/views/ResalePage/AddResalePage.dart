import 'package:ent5m/controllers/ContactsController.dart';
import 'package:ent5m/controllers/ResaleController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddResale extends StatelessWidget {

  final ResaleController resaleController  = Get.put(ResaleController());

  AddResale({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Resale'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const SizedBox(height: 20,),
            TextField(
              controller: resaleController.carDesc,
              decoration: const InputDecoration(labelText: 'Veh Description'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:  resaleController.unit,
              decoration: const InputDecoration(labelText: 'UNIT'),
            ),
            SizedBox(height: 10),
            TextField(
              controller:  resaleController.vin,
              decoration: const InputDecoration(labelText: 'VIN'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:  resaleController.plates,
              decoration: const InputDecoration(labelText: 'PLATES'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Implement the logic to pick the image, upload, and add the shop
                resaleController.addResale();
              },
              child: const Text('Add to resale'),
            ),
          ],
        ),
      ),
    );
  }

}
