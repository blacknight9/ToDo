import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;


const String randomImage = 'https://picsum.photos/600/600';
const String defaultProfilePic = 'https://firebasestorage.googleapis.com/v0/b/sawalif-26bce.appspot.com/o/profilePics%2Frm.png?alt=media&token=714b0409-781c-475c-b642-f7b65a78ccf3';

convertTimestampToDateTime(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is DateTime) {
    return timestamp;
  } else {
    return DateTime.now();
  }
}

String? getRandomId(int? length) {
  var random = Random.secure();
  var values = List<int>.generate(length!, (index) => random.nextInt(255));
  return base64UrlEncode(values);
}
final format = intl.DateFormat.yMMMd();
final format2 = intl.DateFormat.jm();

bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);

}
