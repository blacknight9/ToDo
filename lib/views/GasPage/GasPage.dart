import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/GasModel.dart';
import 'package:ent5m/models/ResaleModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/GasPage/AddGasPage.dart';
import 'package:ent5m/views/ResalePage/AddResalePage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GasPage extends StatelessWidget {
  const GasPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('GAS RECEIPTS'),
        actions: [
          IconButton(onPressed: (){
            Get.bottomSheet(AddGasPage());
          }, icon: const Icon(Icons.add)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.6,
        child: StreamBuilder<QuerySnapshot>(
            stream: CollectionRef.path(path: 'gas').snapshots(),
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
                    GasModel gasModel  = GasModel.fromJson(data.data() as Map<String, dynamic>);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                            leading: const Icon(Icons.local_gas_station,color: Colors.green,),
                            title: Text(gasModel.staffName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mi: ${gasModel.mileage}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                gasModel.unit.isEmpty ?
                                const SizedBox.shrink() :
                                Text('UNIT: ${gasModel.unit}'),
                                gasModel.vin.isEmpty ?
                                const SizedBox.shrink() :
                                Text('VIN: ${gasModel.vin}'),
                                gasModel.plates.isEmpty ?
                                const SizedBox.shrink() :
                                Text('PLATES: ${gasModel.plates}'),
                              ],
                            ),
                            trailing:  Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('\$${gasModel.cost}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                                Text(format3.format(gasModel.timeStamp,),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                              ],
                            )
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
