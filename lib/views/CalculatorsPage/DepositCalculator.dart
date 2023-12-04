import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/CalculatorsController.dart';
import '../ResponsiveMaxWidthContainer.dart';

class DepositCalculator extends StatefulWidget {
  const DepositCalculator({Key? key}) : super(key: key);

  @override
  _DepositCalculatorState createState() => _DepositCalculatorState();
}

class _DepositCalculatorState extends State<DepositCalculator> {
  String calculatedValue = '0.00';
  CalculatorsController calculatorsController = Get.put(CalculatorsController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Calculator')),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.25,
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Display calculated value
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    borderRadius: BorderRadius.circular(15)
                ),
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Center(
                  child: Text('\$$calculatedValue', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Input fields
            _buildInputField(calculatorsController.oop, '\$ PER DAY OUT OF POCKET '),
            _buildInputField(calculatorsController.numOfDays, 'HOW MANY DAYS'),
            _buildInputField(calculatorsController.additional, 'ADDITIONAL CHARGES (TOTAL)'),
            // Add Calculate Button
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            calculatedValue = calculatorsController.calculateDeposit();
          });
        },
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
