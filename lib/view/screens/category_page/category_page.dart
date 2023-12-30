import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uber_shop/view/screens/inner_screens/category_product_screen.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoriesStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Row(
          children: [
            Icon(
              Icons.category,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoriesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final categoryData = snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CategoryProductScreen(
                          categoryData: categoryData,
                        );
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.network(
                          //   categoryData['image'],
                          //   width: 80,
                          //   height: 80,
                          // ),

                          CachedNetworkImage(
                            imageUrl: categoryData['image'],
                            width: 80,
                            height: 80,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            categoryData['categoryName'].toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
