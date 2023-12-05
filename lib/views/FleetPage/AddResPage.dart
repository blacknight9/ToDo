import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ent5m/controllers/FleetController.dart';

import '../../models/AddVanModel.dart';

class AddReservationView extends StatelessWidget {
  final FleetController fleetController = Get.put(FleetController());

  AddReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Reservation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveMaxWidthContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                title: Text('From'),
                subtitle: Obx(() => Text(
                      fleetController.fromDate.value != null
                          ? '${DateFormat('MM-dd-yyyy').format(fleetController.fromDate.value!)} ${DateFormat('hh:mm a').format(fleetController.fromDate.value!)}'
                          : 'Select Date',
                    )),
                trailing: Icon(Icons.date_range),
                onTap: () =>
                    fleetController.pickDate(context, isStartDate: true),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                title: Text('To'),
                subtitle: Obx(() => Text(
                      fleetController.toDate.value != null
                          ? '${DateFormat('MM-dd-yyyy').format(fleetController.toDate.value!)} ${DateFormat('hh:mm a').format(fleetController.toDate.value!)}'
                          : 'Select Date',
                    )),
                trailing: Icon(Icons.date_range),
                onTap: () =>
                    fleetController.pickDate(context, isStartDate: false),
              ),
              TextFormField(
                controller: fleetController.eventNameController,
                decoration: const InputDecoration(labelText: 'Event Name'),
                validator: (value) =>
                    value!.isEmpty ? 'This field cannot be empty' : null,
              ),
              Obx(() => DropdownButtonFormField<AddVanModel>(
                    value: fleetController.selectedVan.value,
                    decoration: const InputDecoration(
                      labelText: 'Select Van',
                    ),
                    items: fleetController.vansList.map((van) {
                      return DropdownMenuItem(
                        value: van,
                         child:Center(
                           child: RichText(
                             text: TextSpan(
                               // Default text style for all spans
                               style: const TextStyle(color: Colors.black,fontSize: 16),
                               children: <TextSpan>[
                                 const TextSpan(
                                   text: 'MAKE: ',
                                   style: TextStyle(fontWeight: FontWeight.bold), // Style for label
                                 ),
                                 TextSpan(
                                   text: '${van.make.toUpperCase()}  ', // Added spaces for separation
                                 ),
                                 const TextSpan(
                                   text: 'UNIT: ',
                                   style: TextStyle(fontWeight: FontWeight.bold), // Style for label
                                 ),
                                 TextSpan(
                                   text: '${van.unitNumber.toUpperCase()}  ', // Added spaces for separation
                                 ),
                                 const TextSpan(
                                   text: 'SEATS: ',
                                   style: TextStyle(fontWeight: FontWeight.bold), // Style for label
                                 ),
                                 TextSpan(
                                   text: van.seats, // No need for toUpperCase() for numbers
                                 ),
                               ],
                             ),
                           ),
                         ),


                        // Center(child: Text(
                        //     '    MAKE: ${van.make.toUpperCase()}'
                        //         '    UNIT: ${van.unitNumber.toUpperCase()}'
                        //         '    SEATS: ${van.seats}')
                        // ,),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     CircleAvatar(backgroundColor: Colors.blue,child: Text(van.seats),),
                        //     Text(c,
                        //     Text(van.unitNumber),
                        //   ],
                        // ),
                      );
                    }).toList(),
                    onChanged: (van) {
                      if (van != null) {
                        fleetController.selectedVan.value = van;
                        // You can access van.unitNumber or other properties here
                        // and do something with it, like saving to a variable
                      }
                    },
                  )),
              TextFormField(
                controller: fleetController.unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
              ),
              TextFormField(
                controller: fleetController.sizeController,
                decoration: InputDecoration(labelText: 'Size'),
              ),
              TextFormField(
                controller: fleetController.noteController,
                decoration: const InputDecoration(labelText: 'Note'),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 5, right: 5),
                title: const Text('Color'),
                trailing: Obx(() => Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: fleetController.currentColor.value,
                        shape: BoxShape.circle,
                      ),
                    )),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Pick a color'),
                        content: SingleChildScrollView(
                            child: ColorPicker(
                          pickerColor: fleetController.currentColor.value,
                          onColorChanged: (Color color) {
                            fleetController.currentColor.value = color;
                          },
                        )),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Done'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              Obx(() => SwitchListTile(
                    contentPadding: const EdgeInsets.only(left: 5, right: 0),
                    title: const Text('All Day Event'),
                    value: fleetController.isAllDay.value,
                    onChanged: (val) => fleetController.isAllDay.value = val,
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Reservation'),
                onPressed: () {
                  fleetController.addAppointment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:ent5m/controllers/FleetController.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:get/get.dart';
//
// class AddReservationView extends StatelessWidget {
//   // Assuming FleetController is injected, or otherwise accessible.
//   final FleetController fleetController = Get.put(FleetController());
//
//   AddReservationView({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Reservation'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: fleetController.eventNameController,
//               decoration: InputDecoration(labelText: 'Event Name'),
//               validator: (value) => value!.isEmpty ? 'This field cannot be empty' : null,
//             ),
//             TextFormField(
//               controller: fleetController.unitController,
//               decoration: InputDecoration(labelText: 'Unit'),
//             ),
//             TextFormField(
//               controller: fleetController.sizeController,
//               decoration: InputDecoration(labelText: 'Size'),
//             ),
//             TextFormField(
//               controller: fleetController.noteController,
//               decoration: InputDecoration(labelText: 'Note'),
//             ),
//             ListTile(
//               title: Text('Color'),
//               trailing: Icon(Icons.palette),
//               onTap: () {
//                 // Open color picker dialog
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text('Pick a color'),
//                       content: SingleChildScrollView(
//                         child: ColorPicker(
//                           pickerColor: fleetController.currentColor,
//                           onColorChanged: fleetController.changeColor,
//                         ),
//                       ),
//                       actions: <Widget>[
//                         ElevatedButton(
//                           child: const Text('Done'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//             ListTile(
//               title: Text('From'),
//               subtitle: Text(
//                 '${fleetController.fromDate}',
//               ),
//               trailing: Icon(Icons.date_range),
//               onTap: () => fleetController.pickDate(context, isStartDate: true),
//             ),
//             ListTile(
//               title: Text('To'),
//               subtitle: Text(
//                 '${fleetController.toDate}',
//               ),
//               trailing: Icon(Icons.date_range),
//               onTap: () => fleetController.pickDate(context, isStartDate: false),
//             ),
//             Obx(
//                 ()=> SwitchListTile(
//                 title: Text('All Day Event'),
//                 value: fleetController.isAllDay.value,
//                 onChanged: fleetController.setAllDay,
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               child: Text('Save Reservation'),
//               onPressed: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
