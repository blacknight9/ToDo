import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/LostAndFoundModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/LostAndFoundController.dart';

class OpenLostAndFoundPage extends StatelessWidget {
  const OpenLostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LostAndFoundController lostAndFoundController =
    Get.put(LostAndFoundController());
    return Scaffold(
      body: ResponsiveMaxWidthContainer(
        child: StreamBuilder(
            stream: CollectionRef.path(path: 'LAF').where('isClosed', isEqualTo: false).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError) {
                print(snapshot.error);
              }
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Text('');
               }
               return ListView.builder(
                   itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context, index){
                     var data= snapshot.data!.docs[index];
                     LostAndFoundModel lostAndFoundModel = LostAndFoundModel.fromJson(data.data() as Map<String,dynamic>);
                 return Column(
                   children: [
                     ListTile(
                       title: Text(lostAndFoundModel.description),
                       subtitle: Text(lostAndFoundModel.foundBy),
                       trailing: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                           InkWell(
                             onTap: (){
                               Get.defaultDialog(
                                 backgroundColor: myAppBar,
                                 title: 'MARK AS CLOSED?',
                                 content: const Text(''),
                                 titleStyle: TextStyle(color: Colors.grey.shade100),
                                 confirmTextColor: Colors.grey.shade100,
                                 confirm: ElevatedButton(
                                   onPressed: (){
                                     lostAndFoundController.closeLAF(lostAndFoundModel.tagId);
                                   }, child: const Text('Close report'),),
                               );
                             },
                               child: const Icon(Icons.check_circle_outline,color: Colors.green,)),
                           Text(format4.format(lostAndFoundModel.timeStamp)),
                         ],
                       ),
                     ),
                     const Divider(),
                   ],
                 );
               });
            }),
      ),
    );
  }
}
