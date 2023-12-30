import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatelessWidget {
  CustomerOrderScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

//DateTime Stamp
  DateTime orderDate(dynamic dateValue) {
    if (dateValue is DateTime) {
      return dateValue;
    } else if (dateValue is String) {
      return DateTime.parse(dateValue);
    } else if (dateValue is Timestamp) {
      return dateValue.toDate();
    } else {
      return dateValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<dynamic, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 8,
                      child: data['accepted'] == true
                          ? const Icon(Icons.delivery_dining)
                          : const Icon(Icons.access_time),
                    ),
                    title: data['accepted'] == true
                        ? const Text(
                            "Accepted",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          )
                        : const Text(
                            "Not Accepted",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                    trailing: Text(
                      data['price'].toStringAsFixed(2),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                  ExpansionTile(
                    subtitle: const Text("View Order Detail"),
                    title: const Text("Order Detail"),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(data['productImage'][0]),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['productName'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            //For Quantity
                            Row(
                              children: [
                                const Text("Quantity"),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  data['quantity'].toString(),
                                )
                              ],
                            )
                          ],
                        ),
                        subtitle: ListTile(
                          title: const Text(
                            "Buyers Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          subtitle: Column(
                            children: [
                              Text(data['fullName']),
                              Text(
                                data['email'],
                              ),
                              Column(
                                children: [
                                  const Text("Order Date "),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    orderDate(data['orderDate']).toString(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
