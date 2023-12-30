import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/account/authentication/login_page.dart';
import 'package:uber_shop/view/screens/auth/login_page.dart';
import 'package:uber_shop/view/screens/auth/signup_page.dart';
import 'package:uber_shop/view/screens/inner_screens/customer_order_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  //const AccountPage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 20, letterSpacing: 4, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.sunny_snowing,
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(_auth.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          // if (snapshot.hasData && !snapshot.data!.exists) {
          //   return const Text("Document does not exist");
          // }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(data['profileImage']),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      data['fullName'].toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, letterSpacing: 5),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignUpPage();
                                },
                              ),
                            );
                          },
                          child: const Text("Edit Profile")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginWithPhone();
                                },
                              ),
                            );
                          },
                          child: const Text("Update Mobile Number")),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      "Setting",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      "Phone",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    subtitle: Text(
                      "7979950560",
                    ),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.shopping_cart),
                    title: Text(
                      "Cart",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cnt) {
                        return CustomerOrderScreen();
                      }));
                    },
                    leading: const Icon(CupertinoIcons.bag),
                    title: const Text(
                      "Orders",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.upload_circle),
                    title: Text(
                      "Registred As Shop",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await _auth
                          .signOut()
                          .whenComplete(() => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginPage();
                                  },
                                ),
                              ));
                    },
                    leading: const Icon(CupertinoIcons.checkmark_seal),
                    title: const Text(
                      "Log Out",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.pink),
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
