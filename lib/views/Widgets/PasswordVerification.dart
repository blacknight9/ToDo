import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/HomeController.dart';
import '../../controllers/SignUpLoginController.dart';


class PasswordVerification extends StatefulWidget {
  VoidCallback onPressed;

   PasswordVerification({required this.onPressed, super.key});

  @override
  State<PasswordVerification> createState() => _PasswordVerificationState();
}

class _PasswordVerificationState extends State<PasswordVerification> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode myFocusNode = FocusNode();

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      myFocusNode.requestFocus();
    });
  }
  @override
  void dispose() {
    myFocusNode.dispose(); // Don't forget to dispose the focus node
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {



    SignUpLoginController signUpLoginController = Get.put(SignUpLoginController());
    HomeController homeController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text('ENTER YOUR PASSWORD'),),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autofocus: true,
                  focusNode: myFocusNode,
                  controller: signUpLoginController.veriPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              TextButton(
                child: const Text('Submit'),
                onPressed: () async {
                  widget.onPressed();
                  // signUpLoginController.verifyPassword(formKey: _formKey, addNoteFn: homeController.addNote );
                },
              ),

            ],
          ),
        ),
      ),
    );

  }

}

// Future<void> showPasswordVerificationDialog(BuildContext context, Function onPasswordVerified) async {
//   final TextEditingController passwordController = TextEditingController();
//   String errorMessage = '';
//
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             title: const Text('Verify Password'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   TextFormField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       errorText: errorMessage.isNotEmpty ? errorMessage : null,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Submit'),
//                 onPressed: () async {
//                   try {
//                     // Assume the user is currently signed in
//                     User? user = FirebaseAuth.instance.currentUser;
//                     String email = user!.email!; // Assuming email is not null
//
//                     // Reauthenticate with Firebase
//                     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//                       email: email,
//                       password: passwordController.text,
//                     );
//
//                     // If successful, close the dialog and call the onPasswordVerified function
//                     Navigator.of(context).pop();
//                     onPasswordVerified();
//                   } on FirebaseAuthException catch (e) {
//                     // If password verification fails, update the error message
//                     if (e.code == 'wrong-password') {
//                       setState(() {
//                         errorMessage = 'Incorrect password. Please try again.';
//                       });
//                     }
//                   }
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
