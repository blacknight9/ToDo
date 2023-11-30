
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/models/HomePanelModel.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';

class NotesPage extends StatelessWidget {

  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('NOTES'),),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('homePanel')
              .orderBy('timeStamp', descending: true)
              .snapshots(),

          builder: (context,snapshot) {
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Text('');
            }

            return ResponsiveMaxWidthContainer(
              child: ListView.builder(
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
              
                  }),
            );

          }
      ),
    );
  }
}
