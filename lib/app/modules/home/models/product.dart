class Product {
  int? id;
  String? nome;
  int? quantidade;
  double? valor;

  Product({this.id, this.nome, this.quantidade, this.valor});

  Product.fromJson(dynamic json) {
    id = json['id'];
    nome = json['nome'];
    quantidade = json['quantidade'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['quantidade'] = quantidade;
    data['valor'] = valor;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['quantidade'] = quantidade;
    data['valor'] = valor;
    return data;
  }

  @override
  String toString() {
    return "id: $id nome: $nome quantidade $quantidade valor $valor";
  }
}
