import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/controllers/CalculatorsController.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constants/currencyInputFormatter.dart';

class MaxRateCalculator extends StatefulWidget {
  const MaxRateCalculator({super.key});

  @override
  State<MaxRateCalculator> createState() => _MaxRateCalculatorState();
}

class _MaxRateCalculatorState extends State<MaxRateCalculator> {
  String calculatedValue ='1.00';


  @override
  Widget build(BuildContext context) {
    CalculatorsController calculatorsController = Get.put(CalculatorsController());
    return Scaffold(
      appBar: AppBar(title: const Text('MaxRate Calculator'),),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.25,
        child: Column(
          children: [

            const SizedBox(height: kIsWeb == true ? 60 : 20,),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: Container(
                decoration:  BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: BorderRadius.circular(15)
                ),
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Center(
                    child: Text('\$$calculatedValue',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),),
              ),
            ),
            const SizedBox(height: 60,),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    // Your calculation function is called here
                    calculatedValue = calculatorsController.calculateMaxRate();
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                controller: calculatorsController.maxRateCont ,
                decoration: InputDecoration(
                  labelText: 'COVERED PER DAY',
                  labelStyle: TextStyle(color: Colors.orange.shade900),
                  // Default border style when TextFormField is in focus
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is enabled but not in focus
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is in focus
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.red.shade900, width: 3.0),
                  ),
                  // You can also define other border styles like errorBorder, focusedErrorBorder, etc.
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    // Your calculation function is called here
                    calculatedValue = calculatorsController.calculateMaxRate();
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                controller: calculatorsController.vlrCont ,
                decoration: InputDecoration(
                  labelText: 'Vehicle License Recovery',
                  labelStyle: TextStyle(color: Colors.orange.shade900),
                  // Default border style when TextFormField is in focus
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is enabled but not in focus
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is in focus
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.red.shade900, width: 3.0),
                  ),
                  // You can also define other border styles like errorBorder, focusedErrorBorder, etc.
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                onChanged: (value) {
                  setState(() {
                    // Your calculation function is called here
                    calculatedValue = calculatorsController.calculateMaxRate();
                  });
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                controller: calculatorsController.salesTaxCont ,
                decoration: InputDecoration(
                  labelText: 'Sales Tax %',
                  labelStyle: TextStyle(color: Colors.orange.shade900),
                  // Default border style when TextFormField is in focus
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is enabled but not in focus
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: myAppBar, width: 2.0),
                  ),
                  // Border style when TextFormField is in focus
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.red.shade900, width: 3.0),
                  ),
                  // You can also define other border styles like errorBorder, focusedErrorBorder, etc.
                ),
              ),
            ),
        
        
          ],
        ),
      ),
    );
  }
}
