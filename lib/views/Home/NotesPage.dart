import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ent5m/controllers/SignUpLoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/controllers/HomeController.dart';
import 'package:ent5m/models/NotesModel.dart';
import 'package:ent5m/views/Home/AddNotePage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:ent5m/views/Widgets/MyExpansionTile.dart';

import '../../constants/Colors.dart';
import '../Widgets/PasswordVerification.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    SignUpLoginController signUpLoginController = Get.put(SignUpLoginController());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(AddNotePage());
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    size: 60,
                  ),
                  color: appBarColor,
                ),
                const SizedBox(height: 20),
                const Text('Add note'),
              ],
            );
          }

          // Separate pinned and unpinned notes
          List<DocumentSnapshot> pinnedNotes = [];
          List<DocumentSnapshot> unpinnedNotes = [];
          for (var doc in snapshot.data!.docs) {
            if (doc['isPinned'] == true && pinnedNotes.isEmpty) {
              pinnedNotes.add(doc);
            } else {
              unpinnedNotes.add(doc);
            }
          }

          // Combine them with pinned notes first
          List<DocumentSnapshot> combinedNotes = [...pinnedNotes, ...unpinnedNotes];

          return ResponsiveMaxWidthContainer(
            child: ListView.builder(
              itemCount: combinedNotes.length,
              itemBuilder: (context, index) {

                var data = combinedNotes[index];


                NotesModel notesModel = NotesModel.fromJson(data.data() as Map<String, dynamic>);
                return
                  notesModel.type == 'contact' ?
                      Padding(
                        padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                        child: Material(
                          color: Colors.transparent,
                          child: Ink(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              onLongPress: () async {
                                if (homeController.currentUserData.first.eid ==
                                    notesModel.staffId || homeController.currentUserData.first.type == 'admin') {
                                  await Get.defaultDialog(
                                    backgroundColor: myAppBar,
                                    titleStyle: TextStyle(color: Colors.grey.shade100),
                                    title: 'Delete Note?',
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              await Get.bottomSheet(PasswordVerification(
                                                  onPressed: () async=>
                                                      signUpLoginController.verifyPassword(
                                                          fn: () async {
                                                            homeController.deleteNote(
                                                                path: 'notes', docId: notesModel.docId);
                                                          })));
                                            },
                                            icon: const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 40,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 40,
                                            )),
                                      ],
                                    ),
                                  );
                                  print('its you');
                                } else {
                                  print('someone else');
                                }
                              },
                              textColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                              leading:  const Icon(Icons.call,color: Colors.orange,),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              tileColor: Colors.blueGrey,
                              title: Text(notesModel.name!),
                              subtitle: Text(notesModel.desc!),
                              trailing: TextButton(onPressed: ()=>makePhoneCall(notesModel.phoneNumber!), child: Text(formatPhoneNumber(notesModel.phoneNumber!),style: TextStyle(color: Colors.grey.shade100),)),
                            ),
                          ),
                        ),
                      ) :
                  notesModel.type == 'resale' ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                          onLongPress: () async {
                            if (homeController.currentUserData.first.eid ==
                                notesModel.staffId || homeController.currentUserData.first.type == 'admin') {
                              await Get.defaultDialog(
                                backgroundColor: myAppBar,
                                titleStyle: TextStyle(color: Colors.grey.shade100),
                                title: 'Delete Note?',
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await Get.bottomSheet(PasswordVerification(
                                              onPressed: () async=>
                                                  signUpLoginController.verifyPassword(
                                                      fn: () async {
                                                        homeController.deleteNote(
                                                            path: 'notes', docId: notesModel.docId);
                                                      })));
                                        },
                                        icon: const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 40,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 40,
                                        )),
                                  ],
                                ),
                              );
                              print('its you');
                            } else {
                              print('someone else');
                            }
                          },
                          contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                          leading:  Icon(Icons.money,color: Colors.green.shade900,),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          tileColor: Colors.grey.shade500,
                          title: Text('${notesModel.carDesc!.toUpperCase()} (${notesModel.type.toUpperCase()})',style: const TextStyle(fontSize: 14),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              notesModel.unit!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('UNIT: ${notesModel.unit!.toUpperCase()}'),
                              notesModel.vin!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('VIN: ${notesModel.vin!.toUpperCase()}'),
                              notesModel.plates!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('PLATES: ${notesModel.plates!.toUpperCase()}'),
                            ],
                          ),
                          trailing: Text(format3.format(notesModel.timeStamp).toUpperCase()),
                        ),
                      ),
                    ),
                  ) :
                  notesModel.type == 'gas' ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                            onLongPress: () async {
                              if (homeController.currentUserData.first.eid ==
                                  notesModel.staffId || homeController.currentUserData.first.type == 'admin') {
                                await Get.defaultDialog(
                                  backgroundColor: myAppBar,
                                  titleStyle: TextStyle(color: Colors.grey.shade100),
                                  title: 'Delete Note?',
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await Get.bottomSheet(PasswordVerification(
                                                onPressed: () async=>
                                                    signUpLoginController.verifyPassword(
                                                        fn: () async {
                                                          homeController.deleteNote(
                                                              path: 'notes', docId: notesModel.docId);
                                                        })));
                                          },
                                          icon: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 40,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 40,
                                          )),
                                    ],
                                  ),
                                );
                                print('its you');
                              } else {
                                print('someone else');
                              }
                            },
                          textColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            visualDensity: VisualDensity.adaptivePlatformDensity,
                            leading: const Icon(Icons.local_gas_station,color: Colors.green,),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          tileColor: Colors.grey.shade800,
                          title: Text(notesModel.userName!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mi: ${formatNumber(int.parse(notesModel.mileage!))}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                              notesModel.unit!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('UNIT: ${notesModel.unit}'),
                              notesModel.vin!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('VIN: ${notesModel.vin}'),
                              notesModel.plates!.isEmpty ?
                              const SizedBox.shrink() :
                              Text('PLATES: ${notesModel.plates}'),
                            ],
                          ),
                          trailing: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\$${notesModel.cost}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
                              Text(format3.format(notesModel.timeStamp,),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                            ],
                          )
                        ),
                      ),
                    ),
                  ) :
                  notesModel.type == 'laf' ?
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                    child: Material(
                      color: Colors.transparent,
                      child: Ink(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                            onLongPress: () async {
                              if (homeController.currentUserData.first.eid ==
                                  notesModel.staffId || homeController.currentUserData.first.type == 'admin') {
                                await Get.defaultDialog(
                                  backgroundColor: myAppBar,
                                  titleStyle: TextStyle(color: Colors.grey.shade100),
                                  title: 'Delete Note?',
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            await Get.bottomSheet(PasswordVerification(
                                                onPressed: () async=>
                                                    signUpLoginController.verifyPassword(
                                                        fn: () async {
                                                          homeController.deleteNote(
                                                              path: 'notes', docId: notesModel.docId);
                                                        })));
                                          },
                                          icon: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 40,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 40,
                                          )),
                                    ],
                                  ),
                                );
                                print('its you');
                              } else {
                                print('someone else');
                              }
                            },
                            textColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                            visualDensity: VisualDensity.adaptivePlatformDensity,
                            leading: Icon(Icons.question_mark,color: Colors.grey.shade100,),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            tileColor: Colors.teal.shade800,
                            title: Text('${notesModel.name!} (L&F)',style: const TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(notesModel.desc!),
                            trailing: Text(format3.format(notesModel.timeStamp,),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),

                        ),
                      ),
                    ),
                  ) :
                  MyExpansionTile(notesModel: notesModel, staffModel:  homeController.currentUserData.first,);
              },
            ),
          );
        },
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ent5m/constants/appConstants.dart';
// import 'package:ent5m/controllers/HomeController.dart';
// import 'package:ent5m/models/NotesModel.dart';
// import 'package:ent5m/views/Home/AddNotePage.dart';
// import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
// import 'package:ent5m/views/Widgets/MyExpansionTile.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constants/Colors.dart';
//
// class NotesPage extends StatelessWidget {
//   const NotesPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     HomeController homeController = Get.put(HomeController());
//
//     return StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('notes')
//             .orderBy('timeStamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Text('');
//           }
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Get.bottomSheet(AddNotePage());
//                   },
//                   icon: Icon(
//                     Icons.add_circle,
//                     size: 60,
//                   ),
//                   color: appBarColor,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text('Add note'),
//               ],
//             );
//           }
//
//           return ResponsiveMaxWidthContainer(
//             child: ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   var data = snapshot.data!.docs[index];
//                   print(data);
//
//                   NotesModel NotesModel = NotesModel.fromJson(
//                       data.data() as Map<String, dynamic>);
//                   return Column(
//                     children: [
//
//                       MyExpansionTile(NotesModel: NotesModel),
//                     ],
//                   );
//                 }),
//           );
//         });
//   }
// }
