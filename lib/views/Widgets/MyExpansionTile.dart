import 'package:ent5m/controllers/HomeController.dart';
import 'package:ent5m/controllers/SignUpLoginController.dart';
import 'package:ent5m/models/NotesModel.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/views/Widgets/PasswordVerification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/Colors.dart';
import '../../constants/appConstants.dart';

class MyExpansionTile extends StatelessWidget {
  const MyExpansionTile(
      {required this.notesModel, required this.staffModel, super.key});

  final NotesModel notesModel;
  final StaffModel staffModel;

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    SignUpLoginController signUpLoginController =
        Get.put(SignUpLoginController());
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: GestureDetector(
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
          child: ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              collapsedTextColor:
                  notesModel.isPinned == true ? Colors.white : Colors.black,
              tilePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              collapsedBackgroundColor: notesModel.isPinned == true
                  ? Colors.red.shade900
                  : myNoteTileColor,
              backgroundColor: myPrimaryAccent,
              leading: CircleAvatar(
                backgroundColor: myAppBar,
                child: Text(
                    staffModel.name.split(' ').map((e) => e[0]).take(2).join()),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${notesModel.userName}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    notesModel.title!.toUpperCase(),
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Visibility(
                    visible: notesModel.isPinned,
                    maintainSize: false,
                    maintainAnimation: false,
                    maintainState: false,
                    child: const Icon(
                      Icons.push_pin,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                  Text(format.format(notesModel.timeStamp)),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(notesModel.message!.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ]),
        ),
      ),
    );
  }
}
