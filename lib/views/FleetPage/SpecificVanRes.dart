import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/models/AddVanModel.dart';
import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appConstants.dart';
import 'ResView.dart';

class SpecificVanRes extends StatelessWidget {
   AddVanModel addVanModel;

   SpecificVanRes({super.key, required this.addVanModel});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('${addVanModel.year ?? ''} ${addVanModel.make ?? ''} ${addVanModel.model ?? ''} ${addVanModel.unitNumber}'),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: CollectionRef.path(path: 'reservations').where('unit', isEqualTo: addVanModel.unitNumber).get(),
          builder: (context, future) {
            if(future.hasError) {
              print(future.error);
            }
            if(!future.hasData) {
              return const Center(child: Text('NO RES FOR THIS UNIT'));
            }
            if(future.connectionState == ConnectionState.waiting) {
              return const Text('');
            }
            return ListView.builder(
                itemCount: future.data!.docs.length,
                itemBuilder: (context, index){
              var data = future.data!.docs[index];
              ResModel resModel = ResModel.fromJson(data.data() as Map<String, dynamic>);

              return Column(
                children: [
                  ListTile(
                    onTap: () => Get.to(
                            () => ResView(resModel: resModel),
                        transition: Transition.downToUp),
                    leading: CircleAvatar(
                      backgroundColor: resModel.size == '12'
                          ? Colors.blue
                          : Colors.green,
                      child: Text(
                        resModel.size,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(resModel.eventName),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            '(DAYS: ${resModel.to.difference(resModel.from).inDays.toString()})')
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('RES#: ${resModel.resNumber}'),
                        Text(
                            '${format4.format(resModel.from)} - ${format4.format(resModel.to)}'),
                      ],
                    ),
                    trailing: Text(
                      resModel.unit,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  const Divider(),
                ],
              );
            });
          }),
    );
  }
}
