import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uber_shop/view/screens/inner_screens/product_detail_screen.dart';

class ProductModel extends StatefulWidget {
  const ProductModel({
    super.key,
    required this.productData,
  });

  final QueryDocumentSnapshot<Object?> productData;

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    int imageIndex = 0;
    return GestureDetector(
      onTap: () {
        Get.to(
          ProductDetailScreen(
            productData: widget.productData,
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffffffff),
                ),
                boxShadow: const [
                  BoxShadow(color: Color.fromARGB(239, 250, 249, 249))
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.productData['productImages'][imageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productData['productName'],
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 4,
                          color: Color.fromARGB(255, 15, 15, 15),
                        ),
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // ignore: prefer_adjacent_string_concatenation
                        "\$" +
                            " " +
                            widget.productData['productPrice']
                                .toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
