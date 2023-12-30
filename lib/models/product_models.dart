import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uber_shop/provider/favorite_provider.dart';
import 'package:uber_shop/view/screens/inner_screens/product_detail_screen.dart';

class ProductModel extends ConsumerStatefulWidget {
  const ProductModel({
    super.key,
    required this.productData,
  });

  final QueryDocumentSnapshot<Object?> productData;

  @override
  // ignore: library_private_types_in_public_api
  _ProductModelState createState() => _ProductModelState();
}

class _ProductModelState extends ConsumerState<ProductModel> {
  @override
  Widget build(BuildContext context) {
    int imageIndex = 0;
    // ignore: no_leading_underscores_for_local_identifiers
    final _favoriteProvider = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);
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
              height: 200,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.productData['productImages'][imageIndex],
                        fit: BoxFit.cover,
                      ),
                      // child: CachedNetworkImage(
                      //   imageUrl: widget.productData['productImages']
                      //       [imageIndex],
                      //   fit: BoxFit.cover,
                      //   placeholder: (context, url) =>
                      //       // const CircularProgressIndicator(),
                      //       // errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),)
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

                        widget.productData['productPrice'].toStringAsFixed(2),
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
              onPressed: () {
                _favoriteProvider.addProductToFavorite(
                  widget.productData['productName'],
                  widget.productData['productId'],
                  widget.productData['productImages'],
                  1,
                  widget.productData['productQuantity'],
                  widget.productData['productPrice'],
                  widget.productData['vendorId'],
                );
              },
              icon: _favoriteProvider.getFavoriteItem
                      .containsKey(widget.productData['productId'])
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
