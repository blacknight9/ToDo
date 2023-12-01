import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Update Home Panel'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: homeController.csController,
              decoration: const InputDecoration(labelText: 'COMPLETELY SATISFIED'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: homeController.soController,
              decoration: const InputDecoration(labelText: 'SHOUT-OUTS'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: homeController.sqiController,
              decoration: const InputDecoration(labelText: 'SQI'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: homeController.hotAlertController,
              decoration: const InputDecoration(labelText: 'HOT ALERT'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: homeController.addRevController,
              decoration: const InputDecoration(labelText: 'AD-REV'),
              keyboardType: TextInputType.number,
            ),
            // ... Other text fields with their respective controllers ...
            SwitchListTile(
              title: Text('Is SO'),
              value: homeController.isSo.value,
              onChanged: (bool value) => homeController.isSo.value = value,
            ),
            ElevatedButton(
              onPressed: () {
                // Update the HomeController values
                homeController.so.value = int.tryParse(homeController.soController.text) ?? 0;
                // ... Update other HomeController values similarly ...

                // Call the method to update Firestore
                homeController.updateHomePanelData();
              },
              child: const Text('Update Data'),
            ),
          ],
        ),
      ),
    );
  }
}
