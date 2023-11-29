import 'package:ent5m/models/FleetPageModel.dart';
import 'package:flutter/material.dart';

import '../Widgets/GridTile.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLEET MANAGEMENT'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: fleetPageModel.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 3, mainAxisExtent: 175, childAspectRatio: 1 / 1),
            itemBuilder: (context, index) {
              return GridTile(
                footer: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Center(
                      child: Text(
                    fleetPageModel[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                ),
                child: MyGridTile(
                    // title: homeList[index].title,
                    icon: fleetPageModel[index].icon,
                    onTap: fleetPageModel[index].onTap),
              );
            }),
      ),
    );
  }
}
