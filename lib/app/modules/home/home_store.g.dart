// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<ObservableList<Product>>? _$listFilteredComputed;

  @override
  ObservableList<Product> get listFiltered => (_$listFilteredComputed ??=
          Computed<ObservableList<Product>>(() => super.listFiltered,
              name: 'HomeStoreBase.listFiltered'))
      .value;

  late final _$productsAtom =
      Atom(name: 'HomeStoreBase.products', context: context);

  @override
  ObservableList<Product> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<Product> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$isSearchActivatedAtom =
      Atom(name: 'HomeStoreBase.isSearchActivated', context: context);

  @override
  bool get isSearchActivated {
    _$isSearchActivatedAtom.reportRead();
    return super.isSearchActivated;
  }

  @override
  set isSearchActivated(bool value) {
    _$isSearchActivatedAtom.reportWrite(value, super.isSearchActivated, () {
      super.isSearchActivated = value;
    });
  }

  late final _$filterTextAtom =
      Atom(name: 'HomeStoreBase.filterText', context: context);

  @override
  String get filterText {
    _$filterTextAtom.reportRead();
    return super.filterText;
  }

  @override
  set filterText(String value) {
    _$filterTextAtom.reportWrite(value, super.filterText, () {
      super.filterText = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void changeSearchActivated() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.changeSearchActivated');
    try {
      return super.changeSearchActivated();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
isSearchActivated: ${isSearchActivated},
filterText: ${filterText},
listFiltered: ${listFiltered}
    ''';
  }
}
