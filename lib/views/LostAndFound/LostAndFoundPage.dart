import 'package:ent5m/views/LostAndFound/ClosedLostAndFound.dart';
import 'package:ent5m/views/LostAndFound/OpenLostAndFound.dart';
import 'package:flutter/material.dart';

class LostAndFoundPage extends StatelessWidget {
  const LostAndFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // The number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LOST AND FOUND'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
          ],
          bottom: const TabBar(
            unselectedLabelColor: Colors.white,
            labelColor: Colors.yellow,
            tabs: [
              Tab(text: 'Open',),
              Tab(text: 'Closed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OpenLostAndFoundPage(), // Replace with your actual widget for this tab
            ClosedLostAndFoundPage(), // Replace with your actual widget for this tab
          ],
        ),
      ),
    );
  }
}
