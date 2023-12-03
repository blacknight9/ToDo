
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpLoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController eid = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support for help.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided for this user.';
    // Add more cases for other error codes as needed
      default:
        return 'An error occurred. Please try again later.';
    }
  }


  Future<void> login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: password.text);
      Get.offAllNamed('/home'); // Navigate to home page after successful login
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseAuthErrorMessage(e);
      Fluttertoast.showToast(msg: errorMessage, timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
    }
  }


  Future<UserCredential?> signUpWithEmail() async {
    var getEid =
    await CollectionRef.path(path: 'staff').doc(eid.text).get();

    if (getEid.exists) {
      Fluttertoast.showToast(msg: 'EID already registered');
    } else {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text,
          password: password.text,
        );
        _createNewStaff(userCredential.user);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        // Handle different Firebase Auth exceptions
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: 'The password provided is too weak.', timeInSecForIosWeb: 3);
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'The account already exists for that email.',
              timeInSecForIosWeb: 3);
        }
        return null;
      } catch (e) {
        // Handle any other exceptions
        print(e.toString());
        return null;
      }
    }

  }

  _createNewStaff(User? user) async {
    try {
      if (user?.uid != null) {
        var getEid =
            await CollectionRef.path(path: 'staff').doc(eid.text).get();

        if (getEid.exists) {
          Fluttertoast.showToast(msg: 'EID already registered');
        } else {
          try{
            await CollectionRef.path(path: 'staff').doc(eid.text).set(StaffModel(
                name: name.text,
                email: email.text,
                uid: user!.uid,
                eid: eid.text,
                timeStamp: DateTime.now().toUtc(),
                type: 'user',
                phoneNumber: phone.text)
                .toJson());
          }
          finally{
            Get.offAllNamed('/');
          }

        }

      }
    } catch (e) {
      print(e);
    }
  }
}
