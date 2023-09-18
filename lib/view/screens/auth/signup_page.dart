import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uber_shop/controllers/auth_controller/auth_controller.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isLoad = false;
  late String email;
  late String fullName;
  late String password;
//Because image are in bytes
  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  signUpUser() async {
    if (_image != null) {
      if (_formkey.currentState!.validate()) {
        setState(() {
          _isLoad = true;
        });
        String res = await _authController.createNewUsr(
            email, fullName, password, _image);
        setState(() {
          _isLoad = false;
        });
        if (res == 'success') {
          setState(() {
            _isLoad = false;
          });
          // ignore: use_build_context_synchronously
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (BuildContext context) {
          //   return const LoginPage();
          // }));
          Get.to(const LoginPage());
          Get.snackbar("Sucess full", "Acount has been Created SucessFull",
              backgroundColor: Colors.pink, margin: const EdgeInsets.all(10));
        } else {
          Get.snackbar(
              "Error occured",
              backgroundColor: Colors.pink,
              margin: const EdgeInsets.all(15),
              res.toString(),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(
                Icons.message,
                color: Colors.white,
              ));
        }
      } else {
        Get.snackbar("Form", "Form Field is not valid",
            backgroundColor: Colors.pink,
            margin: const EdgeInsets.all(10),
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ));
      }
    } else {
      Get.snackbar("No Image", "Please Capture or select an image",
          backgroundColor: Colors.pink,
          margin: const EdgeInsets.all(10),
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.message,
            color: Colors.white,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Stack(
                  children: [
                    if (_image == null)
                      const CircleAvatar(
                        radius: 65,
                        child: Icon(
                          Icons.person,
                          size: 60,
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 65,
                        backgroundImage: MemoryImage(_image!),
                      ),
                    IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: const Icon(
                          Icons.photo,
                        )),

                    // Positioned(
                    //     child: IconButton(
                    //         onPressed: () {

                    //         },
                    //         icon: Icon(Icons.photo)))
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email not Empty";
                    } else {
                      email = value;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefix: Icon(Icons.email),
                    labelText: "Email adress",
                    hintText: "Enter the email Address",
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name Not be Empty";
                    } else {
                      fullName = value;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefix: Icon(Icons.person),
                      hintText: "Enter your full name",
                      labelText: "Your name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Not be empty";
                    } else {
                      password = value;
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      prefix: Icon(Icons.password),
                      labelText: "Passoword",
                      hintText: "Enter your passowrd"),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    signUpUser();
                  },
                  child: Container(
                    color: Colors.pink,
                    height: 50,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Center(
                      child: _isLoad
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Registered ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }));
                    },
                    child: const Text("Already an Account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
