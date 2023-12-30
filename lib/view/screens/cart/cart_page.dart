import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/main_page.dart';
import 'package:uber_shop/provider/cart_provider.dart';
import 'package:uber_shop/view/screens/inner_screens/payment_screen.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    //watch can change and scribecribe the Changes
    //where as read can only read the data
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainPage();
              },
            ),
          );
        }),
        title: const Text("Cart Screen"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: cartData.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                // ignore: no_leading_underscores_for_local_identifiers
                final _cartProvider = ref.read(cartProvider.notifier);
                final cartItem = cartData.values.toList()[index];

                return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                        child: SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              cartItem.imageUrl[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.productName,
                                style: const TextStyle(
                                    //fontSize: 20,
                                    ),
                              ),
                              Text(
                                cartItem.price.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _cartProvider.decrementItems(
                                              cartItem.productId,
                                            );
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          cartItem.quantity.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _cartProvider.incrementItems(
                                              cartItem.productId,
                                            );
                                          },
                                          icon: const Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _cartProvider
                                          .removeItems(cartItem.productId);
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )));
              },
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your WisList Is Empty",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "You have  Not add Any Items To You WishList\n You can Add From Home Screen",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
      // ignore: avoid_unnecessary_containers
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Amount",
            ),
            const Icon(Icons.currency_rupee),
            Text(totalAmount.toStringAsFixed(2)),
            Container(
              color: const Color.fromARGB(146, 255, 255, 255),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const PaymentScreen();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "ChechOut",
                    style: TextStyle(
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
