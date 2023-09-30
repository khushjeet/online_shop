import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/models/car_model.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModels>>(
        (ref) => CartNotifier());

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
          quantity: state[productId]!.quantity + 1,
        )
      };
    } else {
      state = {
        ...state,
        productId: CartModels(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          price: price,
          vendorId: vendorId,
          productSize: productSize,
          productQuantity: productQuantity,
          quantity: quantity,
        )
      };
    }
  }

  Map<String, CartModels> get getCartItems => state;
}
