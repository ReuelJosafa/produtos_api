import '../../../shared/interfaces/http_client_interface.dart';
import '../interfaces/api_products_repository_interface.dart';
import '../models/product.dart';

const String endPointProdutos = 'produtos';

class ApiProductsRepository implements IApiProductRepository {
  final IHttpClient _clientService;

  ApiProductsRepository(this._clientService);

  @override
  Future<List<Product>> fetchProducts() async {
    try {
      final data = await _clientService.get(endPointProdutos) as List;
      return data.map<Product>(Product.fromJson).toList();
    } on int catch (statusCode) {
      if (statusCode == 404) {
        throw ProductsException('Não foi possível carregar os produtos!');
      }
      throw ProductsException(
          'Não foi possível estabelecer conexão com nossos servidores!');
    }
  }

  @override
  Future<dynamic> insertProduct(Product product) async {
    try {
      final data =
          await _clientService.post(endPointProdutos, product.toJson());
      return data;
    } on int catch (statusCode) {
      if (statusCode == 404) {
        throw ProductsException('Não foi possível inserir o produto!');
      }
      throw ProductsException(
          'Não foi possível estabelecer conexão com nossos servidores!');
    }
  }

  @override
  Future<dynamic> updateProduct(Product product) async {
    try {
      final data = await _clientService.uptade(endPointProdutos,
          id: product.id.toString(), data: product.toJsonUpdate());

      return data;
    } on int catch (statusCode) {
      if (statusCode == 404) {
        throw ProductsException('Não foi possível atualizar o produto!');
      }
      throw ProductsException(
          'Não foi possível estabelecer conexão com nossos servidores!');
    }
  }

  @override
  Future<dynamic> deleteProduct(Product product) async {
    try {
      final data = await _clientService.delete(endPointProdutos,
          id: product.id.toString());
      return data;
    } on int catch (statusCode) {
      if (statusCode == 404) {
        throw ProductsException('Não foi possível excluir o produto!');
      }
      throw ProductsException(
          'Não foi possível estabelecer conexão com nossos servidores!');
    }
  }
}

class ProductsException implements Exception {
  final String? message;

  ProductsException([this.message]);
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "Erro";
    return "Erro: $message";
  }
}
