import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/models/product_models.dart';

class ProductsReusesWidgets extends StatelessWidget {
  final String noData;
  final String categoryName;
  const ProductsReusesWidgets(
      {super.key, required this.noData, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('categories', isEqualTo: categoryName)
        .snapshots();
    return StreamBuilder(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something Got Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading....");
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Items in This Category $noData"));
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
        });
  }
}
