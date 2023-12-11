

import 'package:ent5m/views/FleetPage/PackersPage.dart';
import 'package:ent5m/views/GasPage/GasPage.dart';
import 'package:ent5m/views/Home/NotesPage.dart';
import 'package:ent5m/views/LostAndFound/LostAndFoundPage.dart';
import 'package:ent5m/views/PickedUpCars/PickedUpCarsPage.dart';
import 'package:ent5m/views/ResalePage/ResalePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/CalculatorsPage/CalculatorsPage.dart';
import '../views/ContactsPage/ContactsPage.dart';
import '../views/FleetPage/FleetPage.dart';
import '../views/ShopsListPage/ShopsListPage.dart';
import '../views/StaffPage/StaffPage.dart';
import 'TileModel.dart';

List homeList = [
  TileModel(
    icon: Icons.car_rental,
    title: 'VANS',

    onTap: () {

      Get.back();
        Get.to(() => const PackersPage(), transition: Transition.downToUp);
    },
  ),
  TileModel(
      icon: Icons.people_alt,
      title: 'STAFF',
      onTap: () async {
        Get.back();

        Get.to(() => StaffPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.list_alt_rounded,
      title: 'SHOPS LIST',
      onTap: () async {
        Get.back();

        Get.to(() => const ShopsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.contact_phone,
      title: 'CONTACTS',
      onTap: () async {
        Get.back();

        Get.to(() => const ContactsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.car_repair,
      title: 'PICKED UP CARS',

      // });
      onTap: () {
        Get.back();

        Get.to(() => const PickedUpCarsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.car_crash_sharp,
      title: 'RESALE LIST',

      // });
      onTap: () {
        Get.back();

        Get.to(() => const ResalePage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.calculate,
      title: 'CALCULATORS',

      // });
      onTap: () {
        Get.to(() => const CalculatorsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.monetization_on,
      title: 'GAS RECEIPTS',

      // });
      onTap: () {
        Get.back();

        Get.to(() => const GasPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.help_center_outlined,
      title: 'LOST & FOUND',

      // });
      onTap: () {
        Get.back();

        Get.to(() => const LostAndFoundPage(), transition: Transition.downToUp);
      }),
];
