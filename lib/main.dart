import 'package:calendar_view/calendar_view.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/views/Home/HomePage.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: myPrimary,
          appBarTheme: AppBarTheme(backgroundColor: Colors.green.shade900, foregroundColor: Colors.grey.shade100)),
      debugShowCheckedModeBanner: false,
      home: const ResponsiveMaxWidthContainer(maxWidthPercentage: 0.75, child: HomePage()),
    );
  }
}
