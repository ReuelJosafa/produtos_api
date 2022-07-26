import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';
import 'home_store.dart';
import 'interfaces/api_products_repository_interface.dart';
import 'repositories/api_products_repository.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.singleton<HttpClientInterface>((i) => DioRepository(i())),
    // Bind.lazySingleton((i) => HomeStore(HomeService(DioRepository()))),
    Bind.singleton<IApiProductRepository>((i) => ApiProductsRepository(i())),
    Bind.lazySingleton((i) => HomeStore(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((_, __) => const HomePage())),
  ];
}
