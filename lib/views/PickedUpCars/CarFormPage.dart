import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/PickedUpCarsController.dart';

class CarFormPage extends StatelessWidget {
  final PickedUpCarsController controller = Get.put(PickedUpCarsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car Pickup Form")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller.unitNumberController,
              decoration: InputDecoration(labelText: 'Unit Number'),
            ),
            TextField(
              controller: controller.vinController,
              decoration: InputDecoration(labelText: 'VIN'),
            ),
            TextField(
              controller: controller.platesController,
              decoration: InputDecoration(labelText: 'Plates'),
            ),
            TextField(
              controller: controller.stateController,
              decoration: InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: controller.modelController,
              decoration: InputDecoration(labelText: 'Model'),
            ),
            TextField(
              controller: controller.timeController,
              decoration: InputDecoration(labelText: 'Picked From'),
            ),
            TextField(
              controller: controller.staffController,
              decoration: InputDecoration(labelText: 'Staff'),
            ),
            TextField(
              controller: controller.gasController,
              decoration: InputDecoration(labelText: 'Gas'),
            ),
            TextField(
              controller: controller.mileageController,
              decoration: InputDecoration(labelText: 'Mileage'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controller.isDamageController,
              decoration: InputDecoration(labelText: 'Is Damage?'),
            ),
            TextField(
              controller: controller.photoController,
              decoration: InputDecoration(labelText: 'Photo URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.clearControllers(),
              child: Text('Clear Form'),
            ),
          ],
        ),
      ),
    );
  }
}
