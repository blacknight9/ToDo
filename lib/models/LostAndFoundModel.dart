// To parse this JSON data, do
//
//     final lostAndFoundModel = lostAndFoundModelFromJson(jsonString);

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
  final DateTime timeStamp;
  final DateTime dateFound;
  final String isPickedUp;

  LostAndFoundModel({
    required this.description,
    required this.locationFound,
    required this.foundBy,
    required this.uid,
    required this.eid,
    required this.timeStamp,
    required this.dateFound,
    required this.isPickedUp,
  });

  factory LostAndFoundModel.fromJson(Map<String, dynamic> json) => LostAndFoundModel(
    description: json["description"],
    locationFound: json["locationFound"],
    foundBy: json["foundBy"],
    uid: json["uid"],
    eid: json["eid"],
    timeStamp: json["timeStamp"],
    dateFound: json["dateFound"],
    isPickedUp: json["isPickedUp"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "locationFound": locationFound,
    "foundBy": foundBy,
    "uid": uid,
    "eid": eid,
    "timeStamp": timeStamp,
    "dateFound": dateFound,
    "isPickedUp": isPickedUp,
  };
}
