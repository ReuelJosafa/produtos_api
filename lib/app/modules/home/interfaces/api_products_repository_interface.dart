import '../models/product.dart';

abstract class IApiProductRepository {
  Future<List<Product>> fetchProducts();
  Future<dynamic> insertProduct(Product product);
  Future<dynamic> updateProduct(Product product);
  Future<dynamic> deleteProduct(Product product);
}
