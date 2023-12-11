import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/HomeController.dart';

class UpdateHomePanelPage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();



  UpdateHomePanelPage({Key? key}) : super(key: key) {
    // Initialize controllers with current values from HomeController
    homeController.soController.text = homeController.so.value.toString();
    homeController.csController.text = homeController.cs.value.toString();
    homeController.addRevController.text = homeController.addRev.value.toString();
    homeController.hotAlertController.text = homeController.hotAlert.value.toString();
    homeController. sqiController.text = homeController.sqi.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Home Panel'),
        leading: IconButton(
          onPressed: ()=> Get.back(), icon: const Icon(Icons.clear),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
              ()=> SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('SOLD-OUT?'),
                  value: homeController.isSo.value,
                  onChanged: (bool value) {
                    homeController.updateAvailability(value);
                  }
                ),
              ),
              TextField(
                controller: homeController.csController,
                decoration: const InputDecoration(labelText: 'COMPLETELY SATISFIED'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: homeController.soController,
                decoration: const InputDecoration(labelText: 'SHOUT-OUTS'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: homeController.sqiController,
                decoration: const InputDecoration(labelText: 'SQI'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: homeController.hotAlertController,
                decoration: const InputDecoration(labelText: 'HOT ALERT'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),

                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextField(
                controller: homeController.addRevController,
                decoration: const InputDecoration(labelText: 'AD-REV'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),

                ],
              ),
              // ... Other text fields with their respective controllers ...

              ElevatedButton(
                onPressed: () {
                  // Update the HomeController values
                  homeController.so.value = int.tryParse(homeController.soController.text) ?? 0;
                  // ... Update other HomeController values similarly ...
          
                  // Call the method to update Firestore
                  homeController.updateHomePanelData();
                  Get.back();
                },
                child: const Text('Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
