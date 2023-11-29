import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/FleetPage/PackersPage.dart';
import 'TileModel.dart';

List fleetPageModel = [
  TileModel(
      icon: Icons.bus_alert_outlined,
      title: 'PACKERS',
      onTap: () async {
        Get.to(() => const PackersPage(), transition: Transition.downToUp);
      }),
];
