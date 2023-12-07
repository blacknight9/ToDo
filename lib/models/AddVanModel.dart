// To parse this JSON data, do
//
//     final addVanModel = addVanModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddVanModel addVanModelFromMap(String str) => AddVanModel.fromMap(json.decode(str));

String addVanModelToMap(AddVanModel data) => json.encode(data.toMap());

class AddVanModel {
  final String unitNumber;
  final String vin;
  final String make;
  final String model;
  final String year;
  final String plates;
  final String seats;

  AddVanModel({
    required this.unitNumber,
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.plates,
    required this.seats,
  });

  factory AddVanModel.fromMap(Map<String, dynamic> json) => AddVanModel(
    unitNumber: json["unitNumber"],
    vin: json["vin"],
    make: json["make"],
    model: json["model"],
    year: json["year"],
    plates: json["plates"],
    seats: json["seats"],
  );

  Map<String, dynamic> toMap() => {
    "unitNumber": unitNumber,
    "vin": vin,
    "make": make,
    "model": model,
    "year": year,
    "plates": plates,
    "seats": seats,
  };
}
