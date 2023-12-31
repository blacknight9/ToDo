import 'package:ent5m/models/ResModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/FleetPage/ResView.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/appConstants.dart';
import '../../controllers/FleetController.dart';

class Reservations extends StatelessWidget {
  const Reservations({super.key});

  @override
  Widget build(BuildContext context) {
    final FleetController fleetController = Get.put(FleetController());

    return Scaffold(
        appBar: AppBar(
          leading:  IconButton(onPressed: (){
            Get.back();
            fleetController.resSearchResults.clear();
            fleetController.resNumController.clear();
          }, icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text('Reservations'.toUpperCase()),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: ListTile(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white),
                  prefix: IconButton(
                      onPressed: () {
                        fleetController.resSearchResults.clear();
                        fleetController.resNumController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                  suffix: IconButton(
                      onPressed: () {
                        fleetController.searchRes();
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                ),
                style: TextStyle(color: Colors.grey.shade100),
                controller: fleetController.resNumController,
              ),
            ),
          ),
        ),
        body: ResponsiveMaxWidthContainer(
          child: Column(
            children: [
              Obx(
                () => fleetController.resSearchResults.isEmpty
                    ? const SizedBox.shrink()
                    : Material(
                  color: Colors.transparent,
                      child: Ink(
                        child: ListTile(
                            tileColor: Colors.orange.shade500,
                            onTap: () {
                              Get.to(
                                      () => ResView(
                                      resModel:
                                      fleetController.resSearchResults.first),
                                  transition: Transition.downToUp);

                            } ,
                            leading: CircleAvatar(
                              backgroundColor:
                                  fleetController.resSearchResults.first.size ==
                                          '12'
                                      ? Colors.blue
                                      : Colors.green,
                              child: Text(
                                fleetController.resSearchResults.first.size,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(fleetController
                                    .resSearchResults.first.eventName),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '(DAYS: ${fleetController.resSearchResults.first.to.difference(fleetController.resSearchResults.first.from).inDays.toString()})')
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'RES#: ${fleetController.resSearchResults.first.resNumber}'),
                                Text(
                                    '${format4.format(fleetController.resSearchResults.first.from)} - ${format4.format(fleetController.resSearchResults.first.to)}'),
                              ],
                            ),
                            trailing: Text(
                              fleetController.resSearchResults.first.unit,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                      ),
                    ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream:
                        CollectionRef.path(path: 'reservations').orderBy('from').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('');
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            ResModel resModel = ResModel.fromJson(
                                data.data() as Map<String, dynamic>);

                            return Column(
                              children: [
                                ListTile(
                                  onTap: () => Get.to(
                                      () => ResView(resModel: resModel),
                                      transition: Transition.downToUp),
                                  leading: CircleAvatar(
                                    backgroundColor: resModel.size == '12'
                                        ? Colors.blue
                                        : Colors.green,
                                    child: Text(
                                      resModel.size,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(resModel.eventName),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          '(DAYS: ${resModel.to.difference(resModel.from).inDays.toString()})')
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('RES#: ${resModel.resNumber}'),
                                      Text(
                                          '${format4.format(resModel.from)} - ${format4.format(resModel.to)}'),
                                    ],
                                  ),
                                  trailing: Text(
                                    resModel.unit,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          });
                    }),
              ),
            ],
          ),
        ));
  }
}
