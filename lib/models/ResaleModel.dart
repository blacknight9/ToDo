// To parse this JSON data, do
//
//     final resaleModel = resaleModelFromJson(jsonString);

import 'package:ent5m/constants/appConstants.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

ResaleModel resaleModelFromJson(String str) => ResaleModel.fromJson(json.decode(str));

String resaleModelToJson(ResaleModel data) => json.encode(data.toJson());

class ResaleModel {
  final String carDesc;
  final String vin;
  final String unit;
  final String plates;
  final DateTime timeStamp;

  ResaleModel({
    required this.carDesc,
    required this.vin,
    required this.unit,
    required this.plates,
    required this.timeStamp,
  });

  factory ResaleModel.fromJson(Map<String, dynamic> json) => ResaleModel(
    carDesc: json["carDesc"],
    vin: json["vin"],
    unit: json["unit"],
    plates: json["plates"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
  );

  Map<String, dynamic> toJson() => {
    "carDesc": carDesc,
    "vin": vin,
    "unit": unit,
    "plates": plates,
    "timeStamp": timeStamp,
  };
}
