import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/models/HomeList.dart';
import 'package:flutter/material.dart';

import '../Widgets/GridTile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: Text(
          '5M GAME PLAN',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey.shade100),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: myPrimary, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey, width: 0.2)),
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                maxWidth: MediaQuery.of(context).size.width,
                minHeight: 100,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
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
          ))
        ],
      ),
    );
  }
}
