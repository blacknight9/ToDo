import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/controllers/LostAndFoundController.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/appConstants.dart';
import '../../controllers/HomeController.dart';

class AddLostAndFound extends StatefulWidget {
  const AddLostAndFound({super.key});

  @override
  State<AddLostAndFound> createState() => _AddLostAndFoundState();
}

class _AddLostAndFoundState extends State<AddLostAndFound> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LostAndFoundController lostAndFoundController =
      Get.put(LostAndFoundController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lostAndFoundController.tagIdController.text = getRandomId2(8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD LOST&FOUND'),
      ),
      body: SingleChildScrollView(
        child: ResponsiveMaxWidthContainer(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => ListTile(
                      contentPadding: const EdgeInsets.only(left: 5, right: 5),
                      title: Row(
                        children: [
                          lostAndFoundController.date.value == null
                              ? const Text(
                                  '!',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Date Found'),
                        ],
                      ),
                      subtitle: Obx(() => Text(
                            lostAndFoundController.date.value != null
                                ? '${DateFormat('MM-dd-yyyy').format(lostAndFoundController.date.value!)} '
                                : 'Select Date',
                          )),
                      trailing: const Icon(Icons.date_range),
                      onTap: () => lostAndFoundController.pickDate(context),
                    ),
                  ),
                ),
                _buildTexEditor(
                    labelText: 'Description',
                    controller: lostAndFoundController.descriptionController),
                _buildTexEditor(
                    labelText: 'Location found',
                    controller: lostAndFoundController.locationFoundController),
                _buildTexEditor(
                    labelText: 'Unit/Plates/Vin',
                    controller: lostAndFoundController.uniIdController),
                _buildTexEditor(
                    labelText: 'Found by',
                    controller: lostAndFoundController.foundByController),
                _buildTexEditor(
                    labelText: 'Tag Id',
                    controller: lostAndFoundController.tagIdController),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      lostAndFoundController.addLostAndFound(key: _formKey);
                    },
                    child: const Text(
                      'SUBMIT',
                      style: TextStyle(
                          color: myAppBar, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTexEditor(
      {required String labelText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field can\'t be empty';
          }
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
