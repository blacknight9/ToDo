import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/controllers/ShopsController.dart';
import 'package:ent5m/models/ShopsListModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:ent5m/views/ShopsListPage/AddShopPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appConstants.dart';

class ShopsPage extends StatelessWidget {
  const ShopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ShopsController shopsController = Get.put(ShopsController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('SHOPS LIST'),
        actions: [
          IconButton(onPressed: (){
            Get.bottomSheet(AddShopPage());
          }, icon: Icon(Icons.add)),
        ],
      ),
      body: ResponsiveMaxWidthContainer(
        maxWidthPercentage: 0.6,
        child: StreamBuilder<QuerySnapshot>(
            stream: CollectionRef.path(path: 'shopsList').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                print(snapshot.error);
                
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Text('');
        
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    var data = snapshot.data!.docs[index];
                    ShopsListModel shopsListModel = ShopsListModel.fromJson(data.data()  as Map<String, dynamic>);
                    
                    return ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(shopsListModel.logo),),
                      title: Text(shopsListModel.shopName),
                      subtitle: InkWell(
                          onTap: (){
                            shopsController.openMap(shopsListModel.address);
                          },
                          child: Text(shopsListModel.address)),

                      trailing: TextButton(onPressed: () {  
                       makePhoneCall(shopsListModel.phoneNumber);
                      }, child: Text(formatPhoneNumber(shopsListModel.phoneNumber)),),
                    );
                
              });
        
        }),
      ) ,
    );
  }
}
