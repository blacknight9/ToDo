import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/FleetPage/ResView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appConstants.dart';

class Reservations extends StatelessWidget {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservations'.toUpperCase()),
      ),
      body: StreamBuilder(
          stream: CollectionRef.path(path: 'reservations').snapshots(),
          builder: (context, snapshot){
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Text('');
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var data = snapshot.data!.docs[index];
                  ResModel resModel = ResModel.fromJson(data.data() as Map<String, dynamic>);

                  return Column(
                    children: [
                      ListTile(
                        onTap: ()=> Get.to(()=> ResView(resModel: resModel),transition: Transition.downToUp),
                      leading: CircleAvatar(backgroundColor: resModel.size == '12' ? Colors.blue : Colors.green,
                      child: Text(resModel.size,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),
                      title: Row(
                        children: [
                          Text(resModel.eventName),
                          const SizedBox(width: 5,),
                          Text('(DAYS: ${resModel.to.difference(resModel.from).inDays.toString()})')
                        ],
                      ),
                        subtitle: Text('${format4.format(resModel.from)} - ${format4.format(resModel.to)}'),
                        trailing: Text(resModel.unit,style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 14),),
                  ),
                    const Divider(),
                    ],
                  );

            });

      }
      )
    );
  }
}
