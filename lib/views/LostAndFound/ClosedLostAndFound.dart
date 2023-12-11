import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Colors.dart';
import '../../constants/appConstants.dart';
import '../../controllers/LostAndFoundController.dart';
import '../../models/LostAndFoundModel.dart';
import '../../services/firebase_services.dart';

class ClosedLostAndFoundPage extends StatelessWidget {
  const ClosedLostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LostAndFoundController lostAndFoundController =
    Get.put(LostAndFoundController());
    return Scaffold(
      body: ResponsiveMaxWidthContainer(
        child: StreamBuilder(
            stream: CollectionRef.path(path: 'LAF').where('isClosed', isEqualTo: true).snapshots(),
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
                          onTap: ()async{
                           await CollectionRef.path(path: 'staff').where('uid', isEqualTo: lostAndFoundModel.closedById).get().then((value) {
                             for(var x in value.docs) {
                               var data = x.data() as Map<String, dynamic>;
                               Get.defaultDialog(
                                 backgroundColor: myAppBar,
                                   titleStyle: TextStyle(color: Colors.grey.shade100),
                                   title: '${data['name']} closed this ticket',
                                 content: Text('on ${format4.format(lostAndFoundModel.closeTimeStamp!)}',style: TextStyle(color: Colors.grey.shade100),)
                               );
        
                             }
        
                            });
        
        
                          },
                          title: Text(lostAndFoundModel.description),
                          subtitle: Text(lostAndFoundModel.foundBy),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
        
                              const Icon(Icons.check_circle,color: Colors.green,),
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
