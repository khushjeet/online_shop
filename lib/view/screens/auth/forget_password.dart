import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
  // final email = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please login";
                  } else {
                    null;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Enter Email",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      resetPassword(email);
                    }
                  },
                  child: const Text("Send The Link"))
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword(email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
