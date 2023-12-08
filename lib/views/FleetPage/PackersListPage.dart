import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/models/AddVanModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/FleetPage/AddPcakerPage.dart';
import 'package:ent5m/views/FleetPage/SpecificVanRes.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackersListPage extends StatelessWidget {
  const PackersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VANS LIST'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: IconButton(
                  onPressed: () => Get.to(() => AddPackerPage()),
                  icon: const Icon(Icons.add)))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: CollectionRef.path(path: 'packers').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  AddVanModel addVanModel = AddVanModel.fromMap(data.data() as Map<String, dynamic>);

                  return ResponsiveMaxWidthContainer(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Get.to(()=>SpecificVanRes(addVanModel : addVanModel),transition: Transition.downToUp);
                          },
                          leading: CircleAvatar(
                            backgroundColor: addVanModel.seats == '12' ? Colors.blue : Colors.green,
                            child: Center(child: Text(addVanModel.seats,style: const TextStyle(fontWeight: FontWeight.bold),)),
                          ),
                          title: Row(
                            children: [
                              Text(addVanModel.make.toUpperCase()),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(addVanModel.model),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(addVanModel.year),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(addVanModel.unitNumber),
                            ],
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
