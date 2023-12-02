import 'package:ent5m/models/CalculatorsList.dart';
import 'package:ent5m/views/CalculatorsPage/MaxRateCalculator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ResponsiveMaxWidthContainer.dart';
import '../Widgets/GridTile.dart';

class CalculatorsPage extends StatelessWidget {
  const CalculatorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULATORS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: calculatorsList.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: screenSize.width < 600 ? 2 : 3, crossAxisSpacing: 3, mainAxisSpacing: 3, mainAxisExtent: 75, childAspectRatio: 3 / 1),
            itemBuilder: (context, index) {
              return GridTile(
                footer: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Center(
                      child: Text(
                        calculatorsList[index].title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                ),
                child: MyGridTile(
                  // title: homeList[index].title,
                    icon: calculatorsList[index].icon,
                    onTap: calculatorsList[index].onTap),
              );
            }),
      ),
    );
  }
}
