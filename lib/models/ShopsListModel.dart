// To parse this JSON data, do
//
//     final shopsListModel = shopsListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ShopsListModel shopsListModelFromJson(String str) => ShopsListModel.fromJson(json.decode(str));

String shopsListModelToJson(ShopsListModel data) => json.encode(data.toJson());

class ShopsListModel {
  final String shopName;
  final String address;
  final String phoneNumber;

  ShopsListModel({
    required this.shopName,
    required this.address,
    required this.phoneNumber,
  });

  factory ShopsListModel.fromJson(Map<String, dynamic> json) => ShopsListModel(
    shopName: json["shopName"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "shopName": shopName,
    "address": address,
    "phoneNumber": phoneNumber,
  };
}
