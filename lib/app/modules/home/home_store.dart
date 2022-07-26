import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'interfaces/api_products_repository_interface.dart';
import 'models/product.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IApiProductRepository _repository;
  HomeStoreBase(this._repository);

  @observable
  ObservableList<Product> products = ObservableList();
  final productActions = Product();
  @observable
  bool isSearchActivated = false;
  @observable
  String filterText = '';

  final nomeController = TextEditingController();
  final quantidadeController = TextEditingController();
  final valorController = TextEditingController();

  Future<List<Product>> fetchAllProducts() async {
    products.clear();

    final productsList = await _repository.fetchProducts();
    products = productsList.asObservable();
    return productsList;
  }

  @computed
  ObservableList<Product> get listFiltered {
    ObservableList<Product> list = ObservableList();
    list.addAll(products.where((pdct) => pdct.nome!.contains(filterText)));
    return list;
  }

  Future<dynamic> insertProduct() async {
    // final responseData = await _repository.insertProduct(productActions);

    if (productActions.nome != null &&
        productActions.quantidade != null &&
        productActions.valor != null) {
      final responseData = await _repository.insertProduct(productActions);
      return responseData;
    } else {
      throw ('Há campos não preenchidos!');
    }

    // return productsList;
  }

  Future<dynamic> uptadeProduct() async {
    final responseData = await _repository.updateProduct(productActions);
    return responseData;
  }

  Future<dynamic> deleteProduct(Product product) async {
    final responseData = await _repository.deleteProduct(product);
    return responseData;
  }

  void setProductFromControllers() {
    productActions.nome = nomeController.text;
    productActions.quantidade = int.tryParse(quantidadeController.text);
    productActions.valor = double.tryParse(valorController.text);
  }

  void setControllersFromProduct(Product product) {
    //como o id não tem controller, deve-se setar o id no objeto.
    productActions.id = product.id!;
    nomeController.text = product.nome!;
    quantidadeController.text = product.quantidade!.toString();
    valorController.text = product.valor!.toString();
  }

  @action
  void changeSearchActivated() => isSearchActivated = !isSearchActivated;

  void cleanControllers() {
    nomeController.clear();
    quantidadeController.clear();
    valorController.clear();
  }

  void printNewProduct() {
    print(
        '${productActions.id} - ${productActions.nome} - ${productActions.quantidade} - ${productActions.valor}');
  }
}
