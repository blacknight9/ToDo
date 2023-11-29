import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';

class PackersListPage extends StatelessWidget {
  const PackersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: CollectionRef.path(path: 'packers').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                var data = snapshot.data!.docs[index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(data['photo']),),
                title: Row(
                  children: [
                    Text(data['make'].toString().toUpperCase()),
                    const SizedBox(width: 5,),
                    Text(data['model']),
                    const SizedBox(width: 5,),
                    Text(data['year'].toString()),
                  ],
                ),
                subtitle: Row(children: [
                  Text(data['unitNumber']),
                ],),
              );
            });
          }),
    );
  }
}
