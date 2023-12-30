import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/models/product_models.dart';

class LaptopProductWidget extends StatelessWidget {
  const LaptopProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('categories', isEqualTo: 'laptop')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Laptop Product ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey),
            ),
          );
        } else {
          return SizedBox(
            height: 250,
            child: GridView.builder(
              //  scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return ProductModel(productData: productData);
              },
            ),
          );
        }
      },
    );
  }
}
