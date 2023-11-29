import 'package:ent5m/views/Home/CalculatorsPage/CalculatorsPage.dart';
import 'package:ent5m/views/Home/ContactsPage/ContacsPage.dart';
import 'package:ent5m/views/Home/FleetPage/FleetPage.dart';
import 'package:ent5m/views/Home/ShopsListPage/ShopsListPage.dart';
import 'package:ent5m/views/Home/StaffPage/StaffPage.dart';
import 'package:ent5m/views/Home/TodoPage/TodoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'TileModel.dart';

List homeList = [
  TileModel(
      icon: Icons.today_outlined,
      title: 'TO DO',
      onTap: () async {
        Get.to(() => const TodoPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.car_rental,
      title: 'FLEET',
      onTap: () async {
        Get.to(() => const FleetPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.people_alt,
      title: 'STAFF',
      onTap: () async {
        Get.to(() => const StaffPage(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.list_alt,
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
      icon: Icons.calculate,
      title: 'CALCULATORS',

      // });
      onTap: () {
        Get.to(() => const CalculatorsPage(), transition: Transition.downToUp);
      }),
];
