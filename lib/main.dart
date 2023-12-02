import 'package:calendar_view/calendar_view.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/views/CalculatorsPage/CalculatorsPage.dart';
import 'package:ent5m/views/ContactsPage/ContactsPage.dart';
import 'package:ent5m/views/FleetPage/FleetPage.dart';
import 'package:ent5m/views/Home/HomePage.dart';
import 'package:ent5m/views/MenuPage/MenuPage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:ent5m/views/ShopsListPage/ShopsListPage.dart';
import 'package:ent5m/views/StaffPage/StaffPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/ShopsPage', page: () => const ShopsPage()),
      //   GetPage(name: '/MenuPage', page: () => const MenuPage()),
      //   GetPage(name: '/StaffPage', page: () => const StaffPage()),
      //   GetPage(name: '/FleetPage', page: () => const FleetPage()),
      //   GetPage(name: '/ContactsPage', page: () => const ContactsPage()),
      //   GetPage(name: '/CalculatorsPage', page: () => const CalculatorsPage()),
      // ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: myPrimary,
          appBarTheme: AppBarTheme(backgroundColor: myHomeIcons, foregroundColor: Colors.grey.shade100)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
