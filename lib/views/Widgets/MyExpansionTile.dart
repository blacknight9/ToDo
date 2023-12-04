import 'package:ent5m/models/HomePanelModel.dart';
import 'package:ent5m/models/StaffModel.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';
import '../../constants/appConstants.dart';

class MyExpansionTile extends StatelessWidget {
  const MyExpansionTile({required this.homePanelModel, required this.staffModel , super.key});


  final HomePanelModel homePanelModel;
  final StaffModel staffModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          collapsedTextColor: homePanelModel.isPinned == true ? Colors.white : Colors.black,
            tilePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            collapsedBackgroundColor:homePanelModel.isPinned == true ?Colors.red.shade900 : myNoteTileColor,
            backgroundColor: myPrimaryAccent,
            leading: CircleAvatar(
              backgroundColor: myAppBar,child: Text(staffModel.name.split(' ').map((e) => e[0]).take(2).join()),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title:

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Text(
                  '${homePanelModel.userName}: ',
                  style:  const TextStyle(fontWeight: FontWeight.bold ),
                ),
                Text(
                  homePanelModel.title!.toUpperCase(),
                  overflow: TextOverflow.clip,
                ),

              ],
            ),
            subtitle: Row(
              children: [
                Visibility(
                  visible: homePanelModel.isPinned,
                  maintainSize: false,
                  maintainAnimation: false,
                  maintainState: false,
                  child: const Icon(Icons.push_pin, color: Colors.orange,size: 20,),
                ),
                Text(format.format(homePanelModel.timeStamp)),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(homePanelModel.message!.toUpperCase(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14)),
              ),
            ]),
      ),
    );
  }
}
