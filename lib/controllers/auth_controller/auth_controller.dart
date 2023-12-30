import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

//Function to selct image from gallery or camera
  pickProfileImage(ImageSource source) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _imagePicker = ImagePicker();

    // ignore: no_leading_underscores_for_local_identifiers
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else if (_file == null) {
      return const Dialog(
        child: Text("Please Select Image"),
      );
    }
  }

  //Function to upload image to firebase Storage
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('profileImage').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);
    TaskSnapshot snapshot = await uploadTask;

    Future<String> downloadUrl = snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

//for new user
  Future<String> createNewUsr(
      String email, String fullName, String password, Uint8List? image) async {
    String res = "Some eroor Ocurs";

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String downloadUrl = await _uploadImageToStorage(image);

      await _firebaseFirestore
          .collection('buyers')
          .doc(userCredential.user!.uid)
          .set({
        'fullName': fullName,
        'email': email,
        'buyerId': userCredential.user!.uid,
        'profileImage': downloadUrl,
      });
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//Function to use login created user

  Future<String> loginUser(String email, String password) async {
    String res = 'Some eroor';

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
