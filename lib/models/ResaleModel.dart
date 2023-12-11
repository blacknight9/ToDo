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
  final String staffId;
  final String docId;
  final DateTime timeStamp;

  ResaleModel({
    required this.carDesc,
    required this.vin,
    required this.unit,
    required this.staffId,
    required this.plates,
    required this.docId,
    required this.timeStamp,
  });

  factory ResaleModel.fromJson(Map<String, dynamic> json) => ResaleModel(
    carDesc: json["carDesc"],
    docId: json["docId"],
    vin: json["vin"],
    unit: json["unit"],
    staffId: json["staffId"],
    plates: json["plates"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
  );

  Map<String, dynamic> toJson() => {
    "carDesc": carDesc,
    "docId": docId,
    "vin": vin,
    "unit": unit,
    "staffId": staffId,
    "plates": plates,
    "timeStamp": timeStamp,
  };
}
