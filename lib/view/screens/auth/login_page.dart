import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_shop/controllers/auth_controller/auth_controller.dart';
import 'package:uber_shop/main_page.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isloading = false;

  loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      String res = await _authController.loginUser(email, password);
      setState(() {
        _isloading = false;
      });
      if (res == 'success') {
        setState(() {
          _isloading = false;
        });
        Get.to(const MainPage());
        Get.snackbar('Login Sucessfull', 'You are now logined ',
            backgroundColor: Colors.pink, colorText: Colors.white);
      } else {
        Get.snackbar("Unsucessful attempt", "Please create an account",
            colorText: Colors.white,
            backgroundColor: Colors.pink,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("please filled required form",
          "Please enter valid email and password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.email),
                    labelText: "Email Address",
                    hintText: "Enter emal Address",
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please password";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      prefix: Icon(Icons.password),
                      labelText: "Password",
                      hintText: "Enter the password"),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    loginUser();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    //   color: Colors.pink,
                    child: _isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Log in",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 4),
                          ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }));
                    },
                    child: const Text("Create an Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
