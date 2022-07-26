import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:produtos_api/app/modules/home/components/change_theme_ic.dart';

import 'home_store.dart';
import 'models/product.dart';

class HomePage extends StatefulWidget {
  ///'/home'
  static const String id = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeStore>();
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = controller.fetchAllProducts();
    // progressDialog = ProgressDialog(context);
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void productAlertDialog({
    required String alertDialogTitle,
    required String confirmButtonText,
    required Future<void> Function() onPressed,
  }) {
    Widget inputTextFild(String label,
        {TextEditingController? controller, TextInputType? keyboardType}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            label: Text(label),
          ),
        ),
      );
    }

    AlertDialog alertDialog() {
      return AlertDialog(
        title: Text(alertDialogTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              inputTextFild('Digite o nome',
                  controller: controller.nomeController),
              inputTextFild('Digite a quantidade',
                  controller: controller.quantidadeController,
                  keyboardType: TextInputType.number),
              inputTextFild('Digite o valor R\$',
                  controller: controller.valorController,
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar")),
          ElevatedButton(
              onPressed: () async {
                controller.setProductFromControllers();
                controller.printNewProduct();
                await onPressed();
                // progressDialog.show();
                Navigator.pop(context, true);
                // progressDialog.hide();
              },
              child: Text(confirmButtonText)),
        ],
      );
    }

    showDialog(
        context: context,
        builder: (_) {
          return alertDialog();
        }).then((value) {
      controller.cleanControllers();
      if (value != null && value) {
        Future.delayed(const Duration(seconds: 1)).then((_) {
          setState(() {
            _future = controller.fetchAllProducts();
          });
        });
      }
    });
  }

  void onDeleteAlertDialod(Product product) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Confirmação de exclusão'),
            content: Text(
                'Você tem certeza que deseja deletar o produto ${product.nome}'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancelar")),
              ElevatedButton(
                onPressed: () async {
                  await controller.deleteProduct(product);
                  Navigator.pop(context, true);
                },
                child: const Text("CONFIRMAR"),
              )
            ],
          );
        }).then((value) {
      if (value != null && value) {
        setState(() {
          _future = controller.fetchAllProducts();
        });
      }
    });
  }

  Widget _whenDoneWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError && snapshot.data == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(snapshot.error.toString())),
          ElevatedButton(
              onPressed: () async {
                setState(() {
                  _future = controller.fetchAllProducts();
                });
              },
              child: const Text("Tentar novamente"))
        ],
      );
    }
    return controller.listFiltered.isNotEmpty
        ? Observer(builder: (context) {
            return ListView.builder(
                itemCount: controller.listFiltered.length,
                itemBuilder: ((context, index) {
                  final product = controller.listFiltered[index];
                  product.valor = product.valor ?? 0.0;
                  final bool isLastProdct =
                      controller.listFiltered.length == (index + 1);

                  return Padding(
                    padding: EdgeInsets.only(bottom: isLastProdct ? 70 : 0),
                    child: ListTile(
                      leading: Text(product.id.toString()),
                      title: Text(product.nome ?? ''),
                      subtitle: Text('R\$${product.valor!.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Color.fromARGB(255, 244, 67, 54)),
                        onPressed: () => onDeleteAlertDialod(product),
                      ),
                      onTap: () {
                        //Seta os controllers para, no alertDialog, alterar conforme os valores do produto.
                        controller.setControllersFromProduct(product);

                        productAlertDialog(
                            alertDialogTitle: 'Atualizar ${product.nome}',
                            confirmButtonText: 'ATUALIZAR',
                            onPressed: () async {
                              await controller.uptadeProduct();
                              showSnackBar('Produto atualizado com sucesso!');
                            });
                      },
                    ),
                  );
                }));
          })
        : const Center(
            child: Text('Não há produtos na lista!'),
          );
  }

  Widget _appBarTitle() {
    if (controller.isSearchActivated) {
      return TextField(
        onChanged: (value) {
          controller.filterText = value;
        },
      );
    }
    return const Text('Produtos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (context) {
          return _appBarTitle();
        }),
        actions: [
          const ChangeThemeIC(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: controller.changeSearchActivated,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _future = controller.fetchAllProducts();
          });
        },
        child: FutureBuilder(
          future: _future,
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Não há nada para exibir ${snapshot.error}'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center(
                  child: Text('Estado Active'),
                );
              case ConnectionState.done:
                return _whenDoneWidget(snapshot);
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productAlertDialog(
              alertDialogTitle: 'Adicionar Produto',
              confirmButtonText: "CONFIRMAR",
              onPressed: controller.insertProduct);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
