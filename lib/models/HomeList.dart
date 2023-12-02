import 'package:ent5m/views/FleetPage/PackersPage.dart';
import 'package:ent5m/views/NotesPage.dart';
import 'package:ent5m/views/PickedUpCars/PickedUpCarsPage.dart';
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
      onTap: () async {
        Get.to(() => const PackersPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.people_alt,
      title: 'STAFF',
      onTap: () async {
        Get.to(() => const StaffPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.list_alt_rounded,
      title: 'SHOPS LIST',
      onTap: () async {
        Get.to(() => const ShopsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.contact_phone,
      title: 'CONTACTS',
      onTap: () async {
        Get.to(() => const ContactsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.car_repair,
      title: 'PICKED UP CARS',

      // });
      onTap: () {
        Get.to(() => const PickedUpCarsPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.car_crash_sharp,
      title: 'RESALE LIST',

      // });
      onTap: () {
        Get.to(() => const CalculatorsPage(), transition: Transition.downToUp);
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
        Get.to(() => const CalculatorsPage(), transition: Transition.downToUp);
      }),

];
