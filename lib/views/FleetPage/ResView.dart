import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/ResModel.dart';

class ResView extends StatelessWidget {
  final ResModel resModel;

  const ResView({super.key, required this.resModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resModel.eventName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: myPrimaryAccent,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  resModel.eventName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: myAppBar,
                  ),
                ),
                const Divider(color: myAppBar),
                _infoRow('FROM:', DateFormat('MM-dd-yyy').format(resModel.from)),
                _infoRow('TO:', DateFormat('MM-dd-yyy').format(resModel.to)),
                _infoRow('UNIT:', resModel.unit),
                _infoRow('SIZE:', resModel.size),
                const SizedBox(height: 150),
                const Divider(color: myAppBar),
                _infoRow('BOOKED BY:', resModel.staffName),
                _infoRow('DATE OF BOOKING:', DateFormat('MM-dd-yyy').format(resModel.timeStamp)),
                _infoRow('NOTE:', resModel.note),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
