import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/controllers/ResaleController.dart';
import 'package:ent5m/models/ResaleModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ContactsPage/AddContacts.dart';
import 'package:ent5m/views/ResalePage/AddResalePage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ContactsController.dart';

class ResalePage extends StatelessWidget {
  const ResalePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('RESALE LIST'),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>AddResale(),transition: Transition.downToUp);
          }, icon: const Icon(Icons.add)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.6,
        child: StreamBuilder<QuerySnapshot>(
            stream: CollectionRef.path(path: 'resale').snapshots(),
            builder: (context, snapshot){
              if(snapshot.hasError) {
                print(snapshot.error);
              }
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Text('');
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data =snapshot.data!.docs[index];
                    ResaleModel resaleModel = ResaleModel.fromJson(data.data() as Map<String, dynamic>);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.money,color: Colors.green,),
                          title: Text(resaleModel.carDesc),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resaleModel.unit.isEmpty ?
                              const SizedBox.shrink() :
                              Text('UNIT: ${resaleModel.unit}'),
                              resaleModel.vin.isEmpty ?
                              const SizedBox.shrink() :
                              Text('VIN: ${resaleModel.vin}'),
                              resaleModel.plates.isEmpty ?
                              const SizedBox.shrink() :
                              Text('PLATES: ${resaleModel.plates}'),
                            ],
                          ),
                          trailing:  Text(format3.format(resaleModel.timeStamp))
                        ),
                        const Divider()
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
