import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ContactsPage/AddContacts.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/ContactsController.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactsController contactsController  = Get.put(ContactsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTACTS LIST'),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>AddContacts(),transition: Transition.downToUp);
            }, icon: const Icon(Icons.add)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: ResponsiveMaxWidthContainer(
        child: StreamBuilder<QuerySnapshot>(
            stream: CollectionRef.path(path: 'contacts').snapshots(),
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
                          leading: const Icon(Icons.numbers),
                          title: Text(data['name']),
                          subtitle: Text(data['desc']),
                          trailing:  TextButton(onPressed: () {
                           makePhoneCall(data['phoneNumber']);
                          }, child: Text(formatPhoneNumber(data['phoneNumber'])),),
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
