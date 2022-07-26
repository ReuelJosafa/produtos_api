import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:produtos_api/app/modules/home/home_store.dart';
import 'package:produtos_api/app/modules/home/models/product.dart';
import 'package:produtos_api/app/modules/home/repositories/api_products_repository.dart';
import 'package:produtos_api/app/shared/interfaces/http_client_interface.dart';
import 'package:produtos_api/app/shared/services/http_client_service.dart';

class RepoMock extends Mock implements ApiProductsRepository {}

void main() {
  test('Retorna todos os produtos', () async {
    final client = DioSevice(
        Dio(), 'https://teste-mercadinho-udemy.herokuapp.com/api/');

    final homeService = ApiProductsRepository(client);
    // final response = await homeService.insertProduct(newP);
    HomeStore controller = HomeStore(homeService);

    controller.setControllersFromProduct(
        Product(id: 2, nome: 'Bola Atualizada', quantidade: 167, valor: 325.6));
    controller.setProductFromControllers();
    final response = await controller.uptadeProduct();
    expect(response['id'], 2);
    // expect(response[0].nome, 'Bolo de creme');
    // expect(products[1].nome, 'Bolo de creme');
  });

  test('Teste mocktail', () async {
    final repository = RepoMock();
    // final response = await repository.insertProduct(newP);

    /* controller.setControllersFromProduct(
        Product(id: 2, nome: 'Bola Atualizada', quantidade: 167, valor: 325.6));
    controller.setProductFromControllers();
    final response = await controller.uptadeProduct();
    expect(response['id'], 2); */
    when(() => repository.fetchProducts())
        .thenAnswer((_) async => [Product(), Product()]);

    HomeStore controller = HomeStore(repository);
    await controller.fetchAllProducts();
    expect(controller.products.length, 2);

    when(() => repository.insertProduct(Product(
        id: 2,
        nome: 'Bola Atualizada',
        quantidade: 167,
        valor: 325.6))).thenThrow(502);
/*     controller.setControllersFromProduct(
        Product(id: 2, nome: 'Bola Atualizada', quantidade: 167, valor: 325.6));
    controller.setProductFromControllers();
    expect(controller.insertProduct(), ''); */
  });
}
