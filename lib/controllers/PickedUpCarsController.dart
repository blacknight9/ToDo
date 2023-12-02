import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickedUpCarsController extends GetxController {
  var unitNumberController = TextEditingController();
  var vinController = TextEditingController();
  var platesController = TextEditingController();
  var stateController = TextEditingController();
  var modelController = TextEditingController();
  var timeController = TextEditingController(); // Might need special handling for DateTime
  var staffController = TextEditingController();
  var gasController = TextEditingController();
  var mileageController = TextEditingController();
  var isDamageController = TextEditingController();
  var photoController = TextEditingController();

  void clearControllers() {
    unitNumberController.clear();
    vinController.clear();
    platesController.clear();
    stateController.clear();
    modelController.clear();
    timeController.clear();
    staffController.clear();
    gasController.clear();
    mileageController.clear();
    isDamageController.clear();
    photoController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is removed from memory
    unitNumberController.dispose();
    vinController.dispose();
    platesController.dispose();
    stateController.dispose();
    modelController.dispose();
    timeController.dispose();
    staffController.dispose();
    gasController.dispose();
    mileageController.dispose();
    isDamageController.dispose();
    photoController.dispose();
    super.onClose();
  }
}
