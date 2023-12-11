import 'package:ent5m/Middleware/AuthMiddleware.dart';
import 'package:ent5m/constants/Colors.dart';
import 'package:ent5m/views/Home/HomePage.dart';
import 'package:ent5m/views/Signup_Login/LoginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage(),middlewares: [AuthMiddleware()],transition: Transition.downToUp),
        GetPage(name: '/loginPage', page: () => const LoginPage()),
        // GetPage(name: '/StaffPage', page: () => const StaffPage()),
        // GetPage(name: '/FleetPage', page: () => const FleetPage()),
        // GetPage(name: '/ContactsPage', page: () => const ContactsPage()),
        // GetPage(name: '/CalculatorsPage', page: () => const CalculatorsPage()),
      ],
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: myPrimary,
          appBarTheme: AppBarTheme(backgroundColor: myHomeIcons, foregroundColor: Colors.grey.shade100)),
      debugShowCheckedModeBanner: false,

    );
  }
}
