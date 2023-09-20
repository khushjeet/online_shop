import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/models/car_model.dart';

class CartNotifier extends StateNotifier<Map<String, CartModels>> {
  CartNotifier() : super({});

  //add item to cart
  void addProductToCart(
    final String productName,
    final String productId,
    final List imageUrl,
    int quantity,
    int productQuantity,
    final double price,
    final String vendorId,
    final String productSize,
  ) {
    if (state.containsKey(productId)) {
      state = {
        ...state,
        productId: CartModels(
            productName: state[productId]!.productName,
            productId: state[productId]!.productId,
            imageUrl: state[productId]!.imageUrl,
            price: state[productId]!.price,
            vendorId: state[productId]!.vendorId,
            productSize: state[productId]!.productSize,
            productQuantity: state[productId]!.productQuantity,
            quantity: state[productId]!.productQuantity)
      };
    }
  }
}