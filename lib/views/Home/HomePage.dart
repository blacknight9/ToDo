
import 'package:ent5m/views/Home/AddNotePage.dart';
import 'package:ent5m/views/Home/HomePanel.dart';
import 'package:ent5m/views/NotesPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MenuPage/MenuPage.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: AddNotePage()), isDismissible: false);
          }, icon: const Icon(Icons.note_add)),
          IconButton(onPressed: (){
            Get.bottomSheet(const MenuPage());
          }, icon: const Icon(Icons.apps)),
        ],
      ),
      body:
          const Column(
            children: [
              HomePanel(),
              Expanded(child: NotesPage()),
            ],
          ),

    );
  }
}
