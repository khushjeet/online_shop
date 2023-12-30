import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uber_shop/models/favorite_models.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, FavoriteModels>>((ref) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<Map<String, FavoriteModels>> {
  FavoriteNotifier() : super({});
  void addProductToFavorite(
    final String productName,
    final String productId,
    final List imageUrl,
    int quantity,
    int productQuantity,
    final double price,
    final String vendorId,
    // final String productSize,
  ) {
    state[productId] = FavoriteModels(
      productName: productName,
      productId: productId,
      imageUrl: imageUrl,
      quantity: quantity,
      productQuantity: productQuantity,
      price: price,
      vendorId: vendorId,
      //  productSize: productSize,
    );
    //notifier the lisiner that state has changed
    state = {...state};
  }

  void removedAllItems() {
    state.clear();
    //notifir the listenner that state has changed
    state = {...state};
  }

  void removeOneItem(String productId) {
    state.remove(productId);
    //notifier the listenner that has changed
    state = {...state};
  }

  Map<String, FavoriteModels> get getFavoriteItem => state;
}
