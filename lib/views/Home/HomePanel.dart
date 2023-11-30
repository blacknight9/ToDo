import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/HomePanelModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class HomePanel extends StatelessWidget {
  final int maxItemCount = 5; // Max number of documents to fetch

  const HomePanel({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ResponsiveMaxWidthContainer(
        child: Container(
          decoration: BoxDecoration(color: myPrimary, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey, width: 0.2)),
          width: MediaQuery.of(context).size.width,

          child:  StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('homePanel')
                    .orderBy('timeStamp', descending: true).limit(3)
                    .snapshots(),

                builder: (context,snapshot) {
                  if(snapshot.hasError) {
                    print(snapshot.error);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('');
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                      var data = snapshot.data!.docs[index];
                      print(data);

                     HomePanelModel homePanelModel = HomePanelModel.fromJson(data.data() as Map<String,dynamic>);
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.zero,

                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            collapsedBackgroundColor: homePanelModel.type == 'note' ? myNoteTileColor : Colors.transparent,
                            backgroundColor: myPrimaryAccent,
                            // collapsedBackgroundColor: Colors.green.shade600,
                            // collapsedIconColor: Colors.red,
                            leading:  CircleAvatar(backgroundImage: NetworkImage(homePanelModel.dp),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Row(
                              children: [
                                Text('${homePanelModel.userName}: ',style: const TextStyle(fontWeight: FontWeight.bold),),
                                Text(homePanelModel.title ,overflow: TextOverflow.ellipsis,),
                              ],
                            ),
                            subtitle: Text(format.format(homePanelModel.timeStamp)),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(homePanelModel.message),
                              )
                            ],
                          ),
                        ),
                      );

                  });

             }
          ),


        ),

      ),
    );
  }
}
