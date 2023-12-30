import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProductScreen extends StatefulWidget {
  final dynamic categoryData;

  const CategoryProductScreen({super.key, this.categoryData});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productStream = FirebaseFirestore.instance
        .collection('products')
        .where('categories', isEqualTo: widget.categoryData['categoryName'])
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryData['categoryName'],
            style:
                const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: productStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "No product Under\n This Category",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4),
                ),
              );
            }
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 200 / 300),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                return Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Container(
                        height: 170,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(productData['productImages'][0]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productData['productName'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          productData['productPrice'].toStringAsFixed(2),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: Colors.pink),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ));
  }
}
