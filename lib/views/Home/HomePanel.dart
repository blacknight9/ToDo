
import 'package:ent5m/constants/appConstants.dart';
import 'package:ent5m/views/Home/UpdateHomePanelPage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/Colors.dart';
import '../../controllers/HomeController.dart';
import '../Widgets/MyExpansionTile.dart';

class HomePanel extends StatelessWidget {
  final int maxItemCount = 5; // Max number of documents to fetch

  const HomePanel({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());

    DateTime dateTime = DateTime.now().toLocal();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ResponsiveMaxWidthContainer(
        child: GestureDetector(
          onTap: () {
            Get.bottomSheet( UpdateHomePanelPage(),isDismissible: false);
          },
          child: Obx(
            () => Container(
              decoration: BoxDecoration(
                  color:myPrimaryAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: myAppBar, width: 1)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          format.format(dateTime),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: appBarColor,
                              fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'C-SATISFIED: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              homeController.cs.value.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            homeController.isSo.value == true
                                ? const Text(
                                    'SOLD OUT',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                : Text(
                                    'CARS AVAILABLE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade700),
                                  ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'HOT-ALERT: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              homeController.hotAlert.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'BRANCH SQI: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${homeController.sqi.value.toString()}%',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'SHOUT-OUTS: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              homeController.so.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'AD-REV: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$${homeController.addRev.value.toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
