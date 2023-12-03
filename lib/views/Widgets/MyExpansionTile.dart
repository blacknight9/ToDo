import 'package:ent5m/models/HomePanelModel.dart';
import 'package:flutter/material.dart';

import '../../constants/Colors.dart';
import '../../constants/appConstants.dart';

class MyExpansionTile extends StatelessWidget {
  const MyExpansionTile({required this.homePanelModel, super.key});


  final HomePanelModel homePanelModel;

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
          collapsedTextColor: homePanelModel.isPinned == true ? Colors.white : Colors.black,
            tilePadding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            collapsedBackgroundColor:homePanelModel.isPinned == true ?Colors.red.shade900 : myNoteTileColor,
            backgroundColor: myPrimaryAccent,
            // collapsedBackgroundColor: Colors.green.shade600,
            // collapsedIconColor: Colors.red,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(homePanelModel.dp!),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Row(
              children: [
              homePanelModel.isPinned == true ?const Icon(Icons.push_pin,color: Colors.orange,) : const SizedBox.shrink(),
                const SizedBox(width: 5,),
                Text(
                  '${homePanelModel.userName}: ',
                  style:  const TextStyle(fontWeight: FontWeight.bold ),
                ),
                Text(
                  homePanelModel.title!,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            subtitle: Text(format.format(homePanelModel.timeStamp)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(homePanelModel.message!),
              ),
            ]),
      ),
    );
  }
}
