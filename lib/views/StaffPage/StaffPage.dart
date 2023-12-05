import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../Signup_Login/SignupPage.dart';

class StaffPage extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!.uid;
   StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STAFF LIST'),
        actions: [
          IconButton(
              onPressed: () async {
                await CollectionRef.path(path: 'staff').where('uid',isEqualTo: currentUser).get().then((value) {
                  for(var x in value.docs) {
                    var data = x.data() as Map<String,dynamic>;
                    StaffModel staffModel = StaffModel.fromJson(data);
                    if(staffModel.type == 'admin')  {
                      Get.to(() => const SignupPage(),
                          transition: Transition.downToUp);
                    } else {
                      Fluttertoast.showToast(msg: 'You don\'t have permissions');
                    }



                  }

                });

              },
              icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.6,
        child: StreamBuilder<QuerySnapshot>(
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
                            child: Text(
                              staffModel.name.split(' ').map((e) => e[0]).take(2).join(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade100
                              ),
                            ),

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
      ),
    );
  }
}
