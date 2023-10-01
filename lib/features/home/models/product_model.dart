class ProductModel {
  final String productId;
  final String productName;
  final String productDescription;
  final double price;
  final String imageUrl;

  ProductModel(
      {required this.productId,
      required this.productName,
      required this.productDescription,
      required this.price,
      required this.imageUrl});
}
