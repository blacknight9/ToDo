import 'package:ent5m/controllers/SignUpLoginController.dart';
import 'package:ent5m/views/ResponsiveMaxWidthContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    SignUpLoginController signUpLoginController = Get.put(SignUpLoginController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: ResponsiveMaxWidthContainer(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height:25),
              const Text('ENTER YOUR CREDENTIALS',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              const SizedBox(height:25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: signUpLoginController.email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: signUpLoginController.password,
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
              const SizedBox(height:25),
              ElevatedButton(onPressed: (){
                signUpLoginController.login();
              }, child: const Text('LOGIN')),

        
            ],
          ),
        ),
      ),
    );
  }
}
