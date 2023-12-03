// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ent5m/constants/appConstants.dart';
// import 'package:ent5m/controllers/HomeController.dart';
// import 'package:ent5m/models/HomePanelModel.dart';
// import 'package:ent5m/views/Home/AddNotePage.dart';
// import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
// import 'package:ent5m/views/Widgets/MyExpansionTile.dart';
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
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('notes')
//             .orderBy('timeStamp', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
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
//                   icon: const Icon(
//                     Icons.add_circle,
//                     size: 60,
//                   ),
//                   color: appBarColor,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text('Add note'),
//               ],
//             );
//           }
//
//           // Separate pinned and unpinned notes
//           List<DocumentSnapshot> pinnedNotes = [];
//           List<DocumentSnapshot> unpinnedNotes = [];
//           for (var doc in snapshot.data!.docs) {
//             if (doc['isPinned'] == true && pinnedNotes.isEmpty) {
//               pinnedNotes.add(doc);
//             } else {
//               unpinnedNotes.add(doc);
//             }
//           }
//
//           // Combine them with pinned notes first
//           List<DocumentSnapshot> combinedNotes = [...pinnedNotes, ...unpinnedNotes];
//
//           return ResponsiveMaxWidthContainer(
//             child: ListView.builder(
//               itemCount: combinedNotes.length,
//               itemBuilder: (context, index) {
//                 var data = combinedNotes[index];
//
//
//                 HomePanelModel homePanelModel = HomePanelModel.fromJson(data.data() as Map<String, dynamic>);
//                 return
//                   homePanelModel.type == 'contact' ?
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
//                         child: Material(
//                           color: Colors.transparent,
//                           child: Ink(
//
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15)
//                             ),
//                             child: ListTile(
//                               contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
//                               leading:  const Icon(Icons.call,color: Colors.orange,),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                               tileColor: Colors.blueGrey,
//                               title: Text(homePanelModel.name!),
//                               subtitle: Text(homePanelModel.desc!),
//                               trailing: TextButton(onPressed: ()=>makePhoneCall(homePanelModel.phoneNumber!), child: Text(formatPhoneNumber(homePanelModel.phoneNumber!))),
//                             ),
//                           ),
//                         ),
//                       ) :
//                   homePanelModel.type == 'resale' ?
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
//                     child: Material(
//                       color: Colors.transparent,
//                       child: Ink(
//
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
//                           leading: const Icon(Icons.money,color: Colors.green,),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                           tileColor: Colors.yellow.shade200,
//                           title: Text('(${homePanelModel.type.toUpperCase()}) ${homePanelModel.carDesc!}'),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               homePanelModel.unit!.isEmpty ?
//                               const SizedBox.shrink() :
//                               Text('UNIT: ${homePanelModel.unit}'),
//                               homePanelModel.vin!.isEmpty ?
//                               const SizedBox.shrink() :
//                               Text('VIN: ${homePanelModel.vin}'),
//                               homePanelModel.plates!.isEmpty ?
//                               const SizedBox.shrink() :
//                               Text('PLATES: ${homePanelModel.plates}'),
//                             ],
//                           ),
//                           trailing: Text(format3.format(homePanelModel.timeStamp)),
//                         ),
//                       ),
//                     ),
//                   ) :
//
//                   MyExpansionTile(homePanelModel: homePanelModel);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:ent5m/constants/appConstants.dart';
// // import 'package:ent5m/controllers/HomeController.dart';
// // import 'package:ent5m/models/HomePanelModel.dart';
// // import 'package:ent5m/views/Home/AddNotePage.dart';
// // import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
// // import 'package:ent5m/views/Widgets/MyExpansionTile.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// //
// // import '../../constants/Colors.dart';
// //
// // class NotesPage extends StatelessWidget {
// //   const NotesPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     HomeController homeController = Get.put(HomeController());
// //
// //     return StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance
// //             .collection('notes')
// //             .orderBy('timeStamp', descending: true)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             print(snapshot.error);
// //           }
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Text('');
// //           }
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //             return Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 IconButton(
// //                   onPressed: () {
// //                     Get.bottomSheet(AddNotePage());
// //                   },
// //                   icon: Icon(
// //                     Icons.add_circle,
// //                     size: 60,
// //                   ),
// //                   color: appBarColor,
// //                 ),
// //                 SizedBox(
// //                   height: 20,
// //                 ),
// //                 Text('Add note'),
// //               ],
// //             );
// //           }
// //
// //           return ResponsiveMaxWidthContainer(
// //             child: ListView.builder(
// //                 itemCount: snapshot.data!.docs.length,
// //                 itemBuilder: (context, index) {
// //                   var data = snapshot.data!.docs[index];
// //                   print(data);
// //
// //                   HomePanelModel homePanelModel = HomePanelModel.fromJson(
// //                       data.data() as Map<String, dynamic>);
// //                   return Column(
// //                     children: [
// //
// //                       MyExpansionTile(homePanelModel: homePanelModel),
// //                     ],
// //                   );
// //                 }),
// //           );
// //         });
// //   }
// // }
