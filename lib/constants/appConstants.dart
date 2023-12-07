import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';


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

Future<void> makePhoneCall(String phoneNumber) async {
  // Properly create a Uri object from the phone number string
  Uri telUrl = Uri.parse('tel:$phoneNumber');

  if (await canLaunchUrl(telUrl)) {
    await launchUrl(telUrl);
  } else {
    throw 'Could not launch the phone dialer.';
  }
}

String formatPhoneNumber(String number) {
  // Remove any non-digit characters from the input
  String digitsOnly = number.replaceAll(RegExp(r'\D'), '');

  // Check if the string contains exactly 10 digits
  if (digitsOnly.length == 10) {
    // Format the string as (XXX) XXX-XXXX
    return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
  } else {
    // Return the original string or handle the error as needed
    return number;
  }
}

String? getRandomId(int? length) {
  var random = Random.secure();
  var values = List<int>.generate(length!, (index) => random.nextInt(255));
  return base64UrlEncode(values);
}

String getRandomId2(int length) {
  const characters = '0123456789';
  var random = Random.secure();

  return String.fromCharCodes(Iterable.generate(
    length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length)),
  ));
}

final format = intl.DateFormat.yMMMMEEEEd();
///time only
final format2 = intl.DateFormat.jm();
final format3 = intl.DateFormat.MMMEd();
final format4 = intl.DateFormat.yMMMEd();
bool isRTL(String text) {
  return intl.Bidi.detectRtlDirectionality(text);

}
