import 'package:ent5m/views/PickedUpCars/CarFormPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/PickedUpCarsController.dart';

class PickedUpCarsPage extends StatelessWidget {
  const PickedUpCarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PickedUpCarsController controller = Get.put(PickedUpCarsController());

    return Scaffold(
      appBar: AppBar(title: Text('PICKED-UP CARS'),
      actions: [
        IconButton(onPressed: ()=>Get.to(()=>CarFormPage()), icon: Icon(Icons.add))
      ],
      ),
    );
  }
}
