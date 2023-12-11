// To parse this JSON data, do
//
//     final NotesModel = NotesModelFromJson(jsonString);

import 'package:ent5m/constants/appConstants.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

NotesModel NotesModelFromJson(String str) => NotesModel.fromJson(json.decode(str));

String NotesModelToJson(NotesModel data) => json.encode(data.toJson());

class NotesModel {
  final String? title;
  final String? message;
  final bool isPinned;
  final DateTime timeStamp;
  final String? dp;
  final String type;
  final String docId;
  final String? userName;
  final String? name;
  final String? desc;
  final String? phoneNumber;
  final String? carDesc;
  final String? plates;
  final String? vin;
  final String? unit;
  final String? cost;
  final String? staffId;
  final String? mileage;

  NotesModel({
    required this.docId,
    this.plates,
    this.mileage,
    this.staffId,
    this.cost,
    this.vin,
    this.unit,
    this.carDesc,
     this.title,
     this.message,
     required this.isPinned,
    required this.timeStamp,
     this.dp,
    required this.type,
    this.userName,
    this.desc,
    this.phoneNumber,
    this.name
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) => NotesModel(
    desc: json["desc"],
    docId: json["docId"],
    mileage: json["mileage"],
    staffId: json["staffId"],
    cost: json["cost"],
    carDesc: json["carDesc"],
    plates: json["plates"],
    vin: json["vin"],
    unit: json["unit"],
    phoneNumber: json["phoneNumber"],
    name: json["name"],
    title: json["title"],
    message: json["message"],
    isPinned: json["isPinned"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
    dp: json["dp"],
    type: json["type"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "docId": docId,
    "mileage": mileage,
    "staffId": staffId,
    "cost": cost,
    "carDesc": carDesc,
    "plates": plates,
    "vin": vin,
    "unit": unit,
    "name": name,
    "phoneNumber": phoneNumber,
    "desc": desc,
    "message": message,
    "isPinned": isPinned,
    "timeStamp": timeStamp,
    "dp": dp,
    "type": type,
    "userName": userName,
  };
}
