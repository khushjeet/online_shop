import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/models/product_models.dart';

class MenProductsWidgets extends StatelessWidget {
  const MenProductsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('categories', isEqualTo: 'men')
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
              "No Man Product ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey),
            ),
          );
        } else {
          return SizedBox(
            height: 200,
            width: double.infinity,
            child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  return ProductModel(productData: productData);
                }),
          );
        }
      },
    );
  }
}
