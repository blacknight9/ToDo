import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/Singup_Login/SignupPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('STAFF LIST'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const SignupPage(),
                    transition: Transition.downToUp);
              },
              icon: Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: CollectionRef.path(path: 'staff').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('');
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index];
                  StaffModel staffModel =
                      StaffModel.fromJson(data.data() as Map<String, dynamic>);
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: myAppBar,
                          child: Text(staffModel.name.characters.first,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade100),),
                        ),
                        title: Text(staffModel.name),
                        subtitle: Text(data['phoneNumber']),
                        trailing: Text(staffModel.eid),
                      ),
                      const Divider()
                    ],
                  );
                });
          }),
    );
  }
}
