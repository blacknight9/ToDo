import 'dart:convert';
import 'package:ent5m/constants/appConstants.dart';
import 'package:flutter/material.dart';

class ResModel {
  String eventName;
  String size;
  String unit;
  String note;
  String uid;
  String staffId;
  String staffName;
  DateTime from;
  DateTime to;
  DateTime timeStamp;
  Color background;
  bool isAllDay;

  ResModel(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.staffId,
      required this.staffName,
        required this.uid,
        required this.note,
        required this.timeStamp,
      required this.background,
      required this.isAllDay,
      required this.unit,
      required this.size});

  // Convert a ResModel instance into a Map. The keys must correspond
  // to the names of the JSON attributes.
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'staffId': staffId,
      'staffName': staffName,
      'unit': unit,
      'uid': uid,
      'size': size,
      'note': note,
      'timeStamp': timeStamp,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'background': background.value, // Storing color as an integer
      'isAllDay': isAllDay,
    };
  }

  // A method to create an instance of ResModel from a JSON map.
  factory ResModel.fromJson(Map<String, dynamic> json) {
    return ResModel(
      eventName: json['eventName'],
      staffId: json['staffId'],
      staffName: json['staffName'],
      uid: json['uid'],
      timeStamp: convertTimestampToDateTime(json['timeStamp']),
      from: DateTime.parse(json['from']).toLocal(),
      to: DateTime.parse(json['to']).toLocal(),
      background: Color(json['background']),
      isAllDay: json['isAllDay'],
      unit: json['unit'],
      size: json['size'],
      note: json['note'],
    );
  }

  // Helper method to encode a list of ResModel objects to JSON string.
  static String encode(List<ResModel> reservations) => json.encode(
        reservations
            .map<Map<String, dynamic>>((reservation) => reservation.toJson())
            .toList(),
      );

  // Helper method to decode a JSON string to a list of ResModel objects.
  static List<ResModel> decode(String reservations) =>
      (json.decode(reservations) as List<dynamic>)
          .map<ResModel>((item) => ResModel.fromJson(item))
          .toList();
}
