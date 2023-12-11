// To parse this JSON data, do
//
//     final gasModel = gasModelFromJson(jsonString);

import 'package:ent5m/constants/appConstants.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

GasModel gasModelFromJson(String str) => GasModel.fromJson(json.decode(str));

String gasModelToJson(GasModel data) => json.encode(data.toJson());

class GasModel {
  final String staffName;
  final String staffId;
  final String cost;
  final String vin;
  final String plates;
  final String unit;
  final DateTime timeStamp;
  final String mileage;
  final String docId;

  GasModel({
    required this.staffName,
    required this.docId,
    required this.cost,
    required this.vin,
    required this.plates,
    required this.unit,
    required this.timeStamp,
    required this.mileage,
    required this.staffId,
  });

  factory GasModel.fromJson(Map<String, dynamic> json) => GasModel(
    staffName: json["staffName"],
    docId: json["docId"],
    staffId: json["staffId"],
    cost: json["cost"],
    vin: json["vin"],
    plates: json["plates"],
    unit: json["unit"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
    mileage: json["mileage"],
  );

  Map<String, dynamic> toJson() => {
    "staffName": staffName,
    "docId": docId,
    "staffId": staffId,
    "cost": cost,
    "vin": vin,
    "plates": plates,
    "unit": unit,
    "timeStamp": timeStamp,
    "mileage": mileage,
  };
}
