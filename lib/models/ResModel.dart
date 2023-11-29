import 'dart:convert';
import 'package:flutter/material.dart';

class ResModel {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  ResModel(this.eventName, this.from, this.to, this.background, this.isAllDay);

  // Convert a ResModel instance into a Map. The keys must correspond
  // to the names of the JSON attributes.
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'background': background.value, // Storing color as an integer
      'isAllDay': isAllDay,
    };
  }

  // A method to create an instance of ResModel from a JSON map.
  factory ResModel.fromJson(Map<String, dynamic> json) {
    return ResModel(
      json['eventName'],
      DateTime.parse(json['from']).toLocal(),
      DateTime.parse(json['to']).toLocal(),
      Color(json['background']),
      json['isAllDay'],
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
