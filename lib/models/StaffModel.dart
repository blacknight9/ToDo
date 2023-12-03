
import 'dart:convert';

import 'package:ent5m/constants/appConstants.dart';

StaffModel staffModelFromJson(String str) => StaffModel.fromJson(json.decode(str));

String staffModelToJson(StaffModel data) => json.encode(data.toJson());

class StaffModel {
  final String name;
  final String email;
  final String uid;
  final String eid;
  final String phoneNumber;
  final DateTime timeStamp;
  final String type;

  StaffModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.eid,
    required this.timeStamp,
    required this.type,
    required this.phoneNumber
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) => StaffModel(
    name: json["name"],
    email: json["email"],
    uid: json["uid"],
    eid: json["eid"],
    phoneNumber: json["phoneNumber"],
    timeStamp: convertTimestampToDateTime(json["timeStamp"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
    "eid": eid,
    "phoneNumber": phoneNumber,
    "timeStamp": timeStamp,
    "type": type,
  };
}
