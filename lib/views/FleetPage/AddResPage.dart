
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/controllers/SignUpLoginController.dart';
import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ent5m/controllers/FleetController.dart';

import '../../models/AddVanModel.dart';
import '../Widgets/PasswordVerification.dart';

class AddReservationView extends StatefulWidget {
  ResModel? resModel;
  bool isEdit = false;
  DateTime? from;

  AddReservationView({required this.isEdit, this.from,this.resModel, super.key});

  @override
  State<AddReservationView> createState() => _AddReservationViewState();
}

class _AddReservationViewState extends State<AddReservationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FleetController fleetController = Get.put(FleetController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.from != null) {
      fleetController.fromDate.value = widget.from;
    }
    if (widget.isEdit == true) {
      fleetController.eventNameController.text = widget.resModel!.eventName;
      fleetController.phoneController.text = widget.resModel!.phoneNumber;
      fleetController.unitController.text = widget.resModel!.unit;
      fleetController.sizeController.text = widget.resModel!.size;
      fleetController.noteController.text = widget.resModel!.note;
      fleetController.fromDate.value = widget.resModel!.from;
      fleetController.toDate.value = widget.resModel!.to;
      fleetController.timeOfPickup.value = widget.resModel!.timeOfPickup;
      fleetController.currentColor.value = widget.resModel!.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    SignUpLoginController signUpLoginController = Get.put(SignUpLoginController());
    return Scaffold(
      appBar: AppBar(
        title: widget.isEdit == false ? const Text('Add Reservation') : const Text('Update Reservation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ResponsiveMaxWidthContainer(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Obx(
                  () =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 5),
                        title: Row(
                          children: [
                            fleetController.fromDate.value == null ?
                            const Text('!', style: TextStyle(fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),)
                                : const SizedBox.shrink(),
                            const SizedBox(width: 5,),
                            const Text('From'),
                          ],
                        ),
                        subtitle: Obx(() =>
                            Text(
                              fleetController.fromDate.value != null
                                  ? '${DateFormat('MM-dd-yyyy').format(
                                  fleetController.fromDate.value!)} '
                                  : 'Select Date',
                            )),
                        trailing: const Icon(Icons.date_range),
                        onTap: () =>
                            fleetController.pickDate(
                                context, isStartDate: true),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 5),
                        title: Row(
                          children: [
                            fleetController.toDate.value == null ?
                            const Text('!', style: TextStyle(fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),)
                                : const SizedBox.shrink(),
                            const SizedBox(width: 5,),
                            const Text('To'),
                          ],
                        ),
                        subtitle: Obx(() =>
                            Text(
                              fleetController.toDate.value != null
                                  ? '${DateFormat('MM-dd-yyyy').format(
                                  fleetController.toDate.value!)} '
                                  : 'Select Date',
                            )),
                        trailing: const Icon(Icons.date_range),
                        onTap: () =>
                            fleetController.pickDate(
                                context, isStartDate: false),
                      ),
                      ListTile(
                        onTap: ()=> fleetController.selectTime(context),
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 5),
                          title: Row(
                            children: [
                              fleetController.timeOfPickup.value == null ?
                              const Text('!', style: TextStyle(fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),)
                                  : const SizedBox.shrink(),
                              const SizedBox(width: 5,),
                              const Text('Pickup time'),
                            ],
                          ),
                          subtitle: fleetController.timeOfPickup.value == null ?
                          const Text('Select pickup time') : 
                          Text(format2.format(fleetController.timeOfPickup.value!)),
                          trailing:  Icon(Icons.watch_later_outlined),
                      ),
                      TextFormField(
                        controller: fleetController.eventNameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) =>
                        value!.isEmpty ? 'This field cannot be empty' : null,
                      ),
                      TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        controller: fleetController.phoneController,
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'phone'),
                        validator: (value) =>
                        value!.isEmpty ? 'This field cannot be empty' : null,
                      ),

                      Obx(
                            () =>
                            DropdownButtonFormField<AddVanModel>(
                              dropdownColor: Colors.grey.shade300,
                              value: fleetController.selectedVan.value,
                              decoration: const InputDecoration(
                                labelText: 'Select Van',
                              ),
                              items: [
                                const DropdownMenuItem<AddVanModel>(
                                  value: null, // Represents no selection
                                  child: Center(
                                    child: Text("None", style: TextStyle(
                                        color: Colors.black54)),
                                  ),
                                ),
                                ...fleetController.vansList.map((van) {
                                  return DropdownMenuItem<AddVanModel>(
                                    value: van,
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          children: <TextSpan>[
                                            const TextSpan(
                                              text: 'MAKE: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${van.make
                                                  .toUpperCase()}  ',
                                            ),
                                            const TextSpan(
                                              text: 'UNIT: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: '${van.unitNumber
                                                  .toUpperCase()}  ',
                                            ),
                                            const TextSpan(
                                              text: 'SEATS: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: van.seats.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                              onChanged: (van) {
                                fleetController.selectedVan.value = van;
                              },
                            ),
                      ),

                      fleetController.selectedVan.value == null ? TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'This field cannot be empty' : null,
                        controller: fleetController.unitController,
                        decoration: const InputDecoration(labelText: 'Unit'),
                      ) : const SizedBox.shrink(),
                      fleetController.selectedVan.value == null ? TextFormField(
                        validator: (value) =>
                        value!.isEmpty ? 'This field cannot be empty' : null,
                        controller: fleetController.sizeController,
                        decoration: const InputDecoration(labelText: 'Size'),
                      ) : const SizedBox.shrink(),
                      TextFormField(
                        controller: fleetController.noteController,
                        decoration: const InputDecoration(labelText: 'Note'),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(
                            left: 5, right: 5),
                        title: const Text('Color'),
                        trailing: Obx(() =>
                            Container(
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
                                      pickerColor: fleetController.currentColor
                                          .value,
                                      onColorChanged: (Color color) {
                                        fleetController.currentColor.value =
                                            color;
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
                      // Obx(() => SwitchListTile(
                      //       contentPadding: const EdgeInsets.only(left: 5, right: 0),
                      //       title: const Text('All Day Event'),
                      //       value: fleetController.isAllDay.value,
                      //       onChanged: (val) => fleetController.isAllDay.value = val,
                      //     )),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          child: widget.isEdit == false ? const Text('Save Reservation') : const Text('Update Reservation'),
                          onPressed: () {
                            Get.bottomSheet(
                                PasswordVerification(
                                  onPressed: ()  {
                              signUpLoginController.verifyPassword(
                                  fn: () async => await fleetController.addRes(key: _formKey, isEdit: widget.isEdit, resModel: widget.resModel));

                            },));

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
