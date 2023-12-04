
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalculatorsController extends GetxController {
  final TextEditingController maxRateCont = TextEditingController();
  final TextEditingController vlrCont = TextEditingController();
  final TextEditingController salesTaxCont = TextEditingController();
  final TextEditingController oop = TextEditingController();
  final TextEditingController numOfDays = TextEditingController();
  final TextEditingController additional = TextEditingController();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    salesTaxCont.text = 8.35.toString();

  }


  String calculateDeposit() {
    double oopValue = double.tryParse(oop.text) ?? 0.0;
    double numOfDaysValue = double.tryParse(numOfDays.text) ?? 0.0;
    double additionalValue = double.tryParse(additional.text) ?? 0.0;

    double result = (oopValue * numOfDaysValue) + (additionalValue * numOfDaysValue) + 50;

    // Round up to the nearest 10
    result = (result / 10).ceil() * 10;

    return result.toStringAsFixed(2); // You might adjust the decimal places as needed
  }



  String calculateMaxRate() {
    double step1, step2;
    double maxRate, vlr, salesTax;

    try {
      maxRate = double.tryParse(maxRateCont.text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      vlr = double.tryParse(vlrCont.text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      salesTax = double.tryParse(salesTaxCont.text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

    } catch (e) {
      return 'Error: Invalid input';
    }

    step1 = maxRate - vlr;
    step2 = step1 / (1 + salesTax / 100);

    return step2.toStringAsFixed(2); // Format the result to 2 decimal places
  }

}

