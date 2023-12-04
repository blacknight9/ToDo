
import 'package:ent5m/models/StaffModel.dart';
import 'package:ent5m/services/firebase_services.dart';
import 'package:ent5m/views/Home/AddNotePage.dart';
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
  TextEditingController veriPassword = TextEditingController();


  Future<void> verifyPassword({required VoidCallback addNoteFn}) async {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        String email = user!.email!;  // Handle the case when email might be null

        // Create credential
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: veriPassword.text);

        // Reauthenticate with Firebase
        UserCredential userCredential = await user.reauthenticateWithCredential(credential);

        // If successful, perform the desired action here
        // For example, navigate to AddNotePage or the home screen
        // Navigator.of(context).pop(); // You might need to pass the context or use Get.back() if using GetX
          // Your logic for adding a note
          addNoteFn();

        Get.offAllNamed('/'); // Navigate to home after the action
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'wrong-password') {
          // Handle wrong password case
          Fluttertoast.showToast(msg: 'WRONG PASSWORD', timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
        }else if (e.code == 'too-many-requests') {
          Fluttertoast.showToast(msg: 'Access to this account has been temporarily disabled due to many failed login attempts. Please reset your password or try again later.', timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
          // Optionally, navigate the user to a password reset page or display a password reset dialog
        } else {
          // Handle other possible errors
          Fluttertoast.showToast(msg: 'An error occurred', timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
        }
      }

  }

  // Future<void> verifyPassword(GlobalKey<FormState> formKey) async {
  //   if (formKey.currentState!.validate()) {
  //     try {
  //       User? user = FirebaseAuth.instance.currentUser;
  //       String email = user!.email!;  // Make sure to handle the case when email might be null
  //
  //       // Reauthenticate with Firebase
  //       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: email,
  //         password: veriPassword.text,
  //       );
  //
  //       // If successful, you can perform the desired action here
  //       // For example, Navigator.of(context).pop();
  //       if(userCredential.user.)
  //       AddNotePage();
  //       Get.offAllNamed('/');
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'wrong-password') {
  //         // Handle wrong password case
  //         Fluttertoast.showToast(msg: 'WRONG PASSWORD',timeInSecForIosWeb: 3, toastLength: Toast.LENGTH_LONG);
  //       }
  //       // Handle other possible errors
  //     }
  //   }
  // }



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
