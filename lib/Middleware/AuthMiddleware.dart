import 'package:ent5m/views/Home/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check if the user is logged in
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    // If the user is not logged in, redirect them to the login page
    if (!isLoggedIn) {
      return const RouteSettings(name: '/loginPage');
    }

    // If the user is logged in, proceed to the intended route
    return super.redirect('/');
  }
}
