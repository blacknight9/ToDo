
import 'package:ent5m/views/CalculatorsPage/DepositCalculator.dart';
import 'package:ent5m/views/CalculatorsPage/MaxRateCalculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'TileModel.dart';

List calculatorsList = [
  TileModel(
      icon: Icons.calculate,
      title: 'MAX RATE CALC',
      onTap: () async {
        Get.to(() => const MaxRateCalculator(),
            transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.monetization_on,
      title: 'DEPOSIT CALC',
      onTap: () async {
        Get.to(() => const DepositCalculator(), transition: Transition.downToUp);
      }),
  TileModel(
      icon: Icons.construction,
      title: 'COMING SOON',
      onTap: () async {
        return;
        // Get.to(() => const DepositCalculator(), transition: Transition.downToUp);
      }),
];
