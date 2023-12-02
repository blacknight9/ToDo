// To parse this JSON data, do
//
//     final homePanelModel = homePanelModelFromJson(jsonString);

import 'package:ent5m/constants/appConstants.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

HomePanelModel homePanelModelFromJson(String str) => HomePanelModel.fromJson(json.decode(str));

String homePanelModelToJson(HomePanelModel data) => json.encode(data.toJson());

class HomePanelModel {
  final String? title;
  final String? message;
  final bool isPinned;
  final DateTime timeStamp;
  final String? dp;
  final String type;
  final String? userName;
  final String? name;
  final String? desc;
  final String? phoneNumber;

  HomePanelModel({
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

  factory HomePanelModel.fromJson(Map<String, dynamic> json) => HomePanelModel(
    desc: json["desc"],
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
