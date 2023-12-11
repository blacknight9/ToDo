import 'package:flutter/cupertino.dart';

class TileModel {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  TileModel({ required this.icon, required this.title, required this.onTap});
}
