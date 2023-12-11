import 'package:ent5m/models/TileModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/HomeList.dart';
import '../ResponsiveMaxWidthContainer.dart';
import '../Signup_Login/LoginPage.dart';
import '../Widgets/GridTile.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MENU'),
        leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.close)),
        actions: [
          IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Get.offAll(()=>const LoginPage());
          } , icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveMaxWidthContainer(
          child: GridView.builder(
              itemCount: homeList.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: screenSize.width < 600 ? 2 : 3, crossAxisSpacing: 3, mainAxisSpacing: 3, mainAxisExtent: 75, childAspectRatio: 3 / 1),
              itemBuilder: (context, index) {

                TileModel tileModel = TileModel(icon: homeList[index].icon, title: homeList[index].title, onTap: homeList[index].onTap);
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
                      icon: tileModel.icon,
                      onTap: tileModel.onTap,
                  ),
                );
              }),
        ),
      ),
    );
  }
}
