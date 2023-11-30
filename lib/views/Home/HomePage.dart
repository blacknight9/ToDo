import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/models/HomeList.dart';
import 'package:ent5m/views/Home/AddNotePage.dart';
import 'package:ent5m/views/Home/HomePanel.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/GridTile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '5M GAME PLAN',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.bottomSheet(

                SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: AddNotePage()),isScrollControlled: true, isDismissible: false);
          }, icon: Icon(Icons.note_add)),
          // IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Column(
        children: [
          const HomePanel(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveMaxWidthContainer(
              child: GridView.builder(
                  itemCount: homeList.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: screenSize.width < 600 ? 2 : 3, crossAxisSpacing: 3, mainAxisSpacing: 3, mainAxisExtent: 75, childAspectRatio: 3 / 1),
                  itemBuilder: (context, index) {
                    return GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Center(
                            child: Text(
                          homeList[index].title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                      ),
                      child: MyGridTile(
                          // title: homeList[index].title,
                          icon: homeList[index].icon,
                          onTap: homeList[index].onTap),
                    );
                  }),
            ),
          ))
        ],
      ),
    );
  }
}
