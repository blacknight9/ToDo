import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> showPasswordVerificationDialog(BuildContext context, Function onPasswordVerified) async {
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Verify Password'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: errorMessage.isNotEmpty ? errorMessage : null,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Submit'),
                onPressed: () async {
                  try {
                    // Assume the user is currently signed in
                    User? user = FirebaseAuth.instance.currentUser;
                    String email = user!.email!; // Assuming email is not null

                    // Reauthenticate with Firebase
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: passwordController.text,
                    );

                    // If successful, close the dialog and call the onPasswordVerified function
                    Navigator.of(context).pop();
                    onPasswordVerified();
                  } on FirebaseAuthException catch (e) {
                    // If password verification fails, update the error message
                    if (e.code == 'wrong-password') {
                      setState(() {
                        errorMessage = 'Incorrect password. Please try again.';
                      });
                    }
                  }
                },
              ),
            ],
          );
        },
      );
    },
  );
}
