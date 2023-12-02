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
  final String logo;

  ShopsListModel({
    required this.shopName,
    required this.address,
    required this.phoneNumber,
    required this.logo,
  });

  factory ShopsListModel.fromJson(Map<String, dynamic> json) => ShopsListModel(
    shopName: json["shopName"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "shopName": shopName,
    "address": address,
    "phoneNumber": phoneNumber,
    "logo": logo,
  };
}
