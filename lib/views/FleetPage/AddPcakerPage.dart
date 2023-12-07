import 'dart:developer';

import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ent5m/controllers/FleetController.dart';

import '../../models/AddVanModel.dart';

class AddPackerPage extends StatefulWidget {
  DateTime? from;

  AddPackerPage({this.from, super.key});

  @override
  State<AddPackerPage> createState() => _AddPackerPageState();
}

class _AddPackerPageState extends State<AddPackerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FleetController fleetController = Get.put(FleetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD VAN'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveMaxWidthContainer(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: fleetController.packMakeController,
                          decoration: const InputDecoration(labelText: 'MAKE'),
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                        ),
                        TextFormField(
                          controller: fleetController.packModelController,
                          decoration: const InputDecoration(labelText: 'MODEL'),
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                        ),
                        TextFormField(
                          controller: fleetController.packYearController,
                          decoration: const InputDecoration(labelText: 'YEAR'),
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                        ),
                        TextFormField(
                          controller: fleetController.packUnitController,
                          decoration: const InputDecoration(labelText: 'UNIT'),
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                        ),

                       TextFormField(
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                          controller: fleetController.packVinController,
                          decoration: const InputDecoration(labelText: 'VIN'),
                        ) ,
                        TextFormField(
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                          controller: fleetController.packPlatesController,
                          decoration: const InputDecoration(labelText: 'PLATES'),
                        ) ,
                        TextFormField(
                          validator: (value) =>
                          value!.isEmpty ? 'This field cannot be empty' : null,
                          controller: fleetController.packSeatsController,
                          decoration: const InputDecoration(labelText: 'SEATS'),
                        ) ,

                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            child: const Text('Save Reservation'),
                            onPressed: () {
                              fleetController.addPacker(_formKey);
                            },
                          ),
                        ),
                      ],
                    ),
            ),

          ),
        ),
      ),
    );
  }
}
