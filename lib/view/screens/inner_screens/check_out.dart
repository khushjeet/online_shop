import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:uber_shop/provider/cart_provider.dart';
import 'package:uber_shop/view/screens/inner_screens/customer_order_screen.dart';
import 'package:uuid/uuid.dart';

class CheckOutPage extends ConsumerStatefulWidget {
  const CheckOutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends ConsumerState<CheckOutPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // ignore: no_leading_underscores_for_local_identifiers
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    // ignore: no_leading_underscores_for_local_identifiers
    final _cartProvider = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Check Out"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: cartData.length,
        itemBuilder: (context, index) {
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
                              fontWeight: FontWeight.bold, color: Colors.pink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () async {
            setState(() {
              _isLoading = true;
            });
            DocumentSnapshot userDoc = await _firestore
                .collection('buyers')
                .doc(_auth.currentUser!.uid)
                .get();
            _cartProvider.getCartItems.forEach((key, item) async {
              final orderId = const Uuid().v4();
              await _firestore.collection('orders').doc(orderId).set({
                'orderId': orderId,
                'productId': item.productId,
                'productName': item.productName,
                'quantity': item.quantity,
                'price': item.quantity * item.price,
                'fullName':
                    (userDoc.data() as Map<String, dynamic>)['fullName'],
                'email': (userDoc.data() as Map<String, dynamic>)['email'],
                'profileImage':
                    (userDoc.data() as Map<String, dynamic>)['profileImage'],
                'buyerId': _auth.currentUser!.uid,
                'vendorId': item.vendorId,
                'productSize': item.productSize,
                'productImage': item.imageUrl,
                'vendorQuantity': item.productQuantity,
                'accepted': false,
                'orderDate': DateTime.now()
              }).whenComplete(() {
                setState(() {
                  _isLoading = false;
                  Get.to(
                    CustomerOrderScreen(),
                  );
                });
              });
            });
          },
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 179, 6, 6),
                  ),
                )
              : Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Check Out  ${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
