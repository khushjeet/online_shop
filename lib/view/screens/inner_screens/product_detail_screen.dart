import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/provider/cart_provider.dart';
import 'package:uber_shop/provider/selected_sized_provider.dart';
import 'package:uber_shop/view/screens/inner_screens/cosumer_chat_screen.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, this.productData});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    final selectedSized = ref.watch(slelectedSizeProvider);
    // ignore: no_leading_underscores_for_local_identifiers
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartItem = ref.watch(cartProvider);
    final isInCart = cartItem.containsKey(widget.productData['productId']);
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text(
          widget.productData['productName'],
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 3,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    // child: Image.network(
                    //   widget.productData['productImages'][imageIndex],
                    //   fit: BoxFit.cover,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: widget.productData['productImages'][imageIndex],
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['productImages'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                imageIndex = index;
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              // child: Image.network(
                              //   widget.productData['productImages'][imageIndex],
                              // ),
                              child: CachedNetworkImage(
                                imageUrl: widget.productData['productImages']
                                    [imageIndex],
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productData['productName'],
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              // ignore: prefer_interpolation_to_compose_strings
              '\$' + widget.productData['productPrice'].toStringAsFixed(2),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: const Row(
                children: [
                  Text('Product Decription'),
                  SizedBox(width: 50),
                  Text(
                    "Vew More",
                    style: TextStyle(
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
              children: [
                Text(
                  widget.productData['description'],
                  style: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.5,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: const Text(
                ' Variation Availible',
              ),
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: OutlinedButton(
                            onPressed: () {
                              final newSelected =
                                  widget.productData['sizeList'][index];
                              ref
                                  .read(slelectedSizeProvider.notifier)
                                  .selSelectedSize(newSelected);
                            },
                            child: Text(
                              widget.productData['sizeList'][index],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  widget.productData['storeImage'],
                ),
              ),
              title: Text(
                widget.productData['bussinessName'],
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'SEE PROFILE',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: isInCart
                  ? null
                  : () {
                      _cartProvider.addProductToCart(
                        widget.productData['productName'],
                        widget.productData['productId'],
                        widget.productData['productImages'],
                        1,
                        widget.productData['productQuantity'],
                        widget.productData['productPrice'],
                        widget.productData['vendorId'],
                        selectedSized,
                      );
                      //  print(_cartProvider.getCartItems.values.first.productName);
                    },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.shopping_cart,
                        color: isInCart ? Colors.green : Colors.pink,
                      ),
                      Text(
                        isInCart ? "IN CART" : "ADD TO CART",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.pink,
                          letterSpacing: 3,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ConsumerChatScreen();
                    },
                  ),
                );
              },
              icon: const Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.pink,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.phone,
                  color: Colors.pink,
                ))
          ],
        ),
      ),
    );
  }
}
