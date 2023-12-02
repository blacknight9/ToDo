import 'package:ent5m/views/CalculatorsPage/MaxRateCalculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCULATORS'),
        actions: [
          IconButton(onPressed: ()=>Get.to(()=>const MaxRateCalculator()), icon: Icon(Icons.calculate))
        ],
      ),
    );
  }
}
