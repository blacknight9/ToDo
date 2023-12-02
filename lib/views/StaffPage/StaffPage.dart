import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:flutter/material.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STAFF LIST'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add)),
          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: CollectionRef.path(path: 'staff').snapshots(),
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
              return Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(backgroundImage: NetworkImage(randomImage),),
                    title: Text(data['name']),
                    subtitle: Text(data['phoneNumber']),
                    trailing: Text(data['staffId']),
                  ),
                  const Divider()
                ],
              );
            });
          }),
    );
  }
}
