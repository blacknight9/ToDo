import 'package:ent5m/views/Home/CalculatorsPage/CalculatorsPage.dart';
import 'package:ent5m/views/Home/ContactsPage/ContacsPage.dart';
import 'package:ent5m/views/Home/FleetPage/FleetPage.dart';
import 'package:ent5m/views/Home/FleetPage/PackersPage.dart';
import 'package:ent5m/views/Home/ShopsListPage/ShopsListPage.dart';
import 'package:ent5m/views/Home/StaffPage/StaffPage.dart';
import 'package:ent5m/views/Home/TodoPage/TodoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'TileModel.dart';

List fleetPageModel = [
  TileModel(
      icon: Icons.bus_alert_outlined,
      title: 'PACKERS',
      onTap: () async {
        Get.to(() => const PackersPage(), transition: Transition.downToUp);
      }),

];
