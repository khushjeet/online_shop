class CartModels {
  final String productName;
  final String productId;
  final List imageUrl;

  int quantity = 0;

  int productQuantity = 0;

  final double price;

  final String vendorId;
  final String productSize;

  CartModels({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.price,
    required this.vendorId,
    required this.productSize,
    required int productQuantity,
    required int quantity,
  });
}
