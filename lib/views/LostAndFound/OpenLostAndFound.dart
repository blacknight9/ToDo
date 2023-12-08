import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/LostAndFoundModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';

class OpenLostAndFoundPage extends StatelessWidget {
  const OpenLostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
                     trailing: Text(format4.format(lostAndFoundModel.timeStamp)),
                   ),
                   const Divider(),
                 ],
               );
             });
          }),
    );
  }
}
