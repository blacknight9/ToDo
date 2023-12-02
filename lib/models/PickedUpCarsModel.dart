// To parse this JSON data, do
//
//     final pickedUpCarsModel = pickedUpCarsModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PickedUpCarsModel pickedUpCarsModelFromMap(String str) => PickedUpCarsModel.fromMap(json.decode(str));

String pickedUpCarsModelToMap(PickedUpCarsModel data) => json.encode(data.toMap());

class PickedUpCarsModel {
  final String unitNumber;
  final String vin;
  final String plates;
  final String state;
  final String model;
  final DateTime time;
  final String staff;
  final String gas;
  final String pickedUpFrom;
  final int mileage;
  final bool isDamage;
  final bool isClosed;
  final String photo;

  PickedUpCarsModel({
    required this.unitNumber,
    required this.vin,
    required this.plates,
    required this.state,
    required this.model,
    required this.time,
    required this.staff,
    required this.gas,
    required this.mileage,
    required this.isDamage,
    required this.photo,
    required this.pickedUpFrom,
    required this.isClosed,
  });

  factory PickedUpCarsModel.fromMap(Map<String, dynamic> json) => PickedUpCarsModel(
    unitNumber: json["unitNumber"],
    vin: json["vin"],
    plates: json["plates"],
    state: json["state"],
    model: json["model"],
    time: json["time"],
    staff: json["staff"],
    gas: json["gas"],
    mileage: json["mileage"],
    isDamage: json["isDamage"],
    pickedUpFrom: json["pickedUpFrom"],
    isClosed: json["isClosed"],
    photo: json["photo"],
  );

  Map<String, dynamic> toMap() => {
    "unitNumber": unitNumber,
    "vin": vin,
    "plates": plates,
    "state": state,
    "model": model,
    "time": time,
    "staff": staff,
    "gas": gas,
    "mileage": mileage,
    "isDamage": isDamage,
    "photo": photo,
    "isClosed": isClosed,
    "pickedUpFrom": pickedUpFrom,
  };
}
