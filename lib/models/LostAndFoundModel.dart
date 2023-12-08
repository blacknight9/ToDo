// To parse this JSON data, do
//
//     final lostAndFoundModel = lostAndFoundModelFromJson(jsonString);

import 'package:ent5m/constants/appConstants.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

LostAndFoundModel lostAndFoundModelFromJson(String str) => LostAndFoundModel.fromJson(json.decode(str));

String lostAndFoundModelToJson(LostAndFoundModel data) => json.encode(data.toJson());

class LostAndFoundModel {
  final String description;
  final String locationFound;
  final String foundBy;
  final String uid;
  final String eid;
  final String unit;
  final DateTime timeStamp;
  final DateTime dateFound;
  final bool isClosed;

  LostAndFoundModel({
    required this.description,
    required this.locationFound,
    required this.foundBy,
    required this.uid,
    required this.unit,
    required this.eid,
    required this.timeStamp,
    required this.dateFound,
    required this.isClosed,
  });

  factory LostAndFoundModel.fromJson(Map<String, dynamic> json) => LostAndFoundModel(
    description: json["description"],
    locationFound: json["locationFound"],
    foundBy: json["foundBy"],
    uid: json["uid"],
    unit: json["unit"],
    eid: json["eid"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
    dateFound: convertTimestampToDateTime(json["dateFound"]),
    isClosed: json["isClosed"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "locationFound": locationFound,
    "foundBy": foundBy,
    "uid": uid,
    "eid": eid,
    "unit": unit,
    "timeStamp": timeStamp,
    "dateFound": dateFound,
    "isClosed": isClosed,
  };
}
