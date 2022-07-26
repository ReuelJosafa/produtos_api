import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:produtos_api/app/shared/const/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_controleller.dart';
import 'modules/home/home_module.dart';
import 'modules/home/home_page.dart';
import 'shared/interfaces/http_client_interface.dart';
import 'shared/interfaces/local_storage_interface.dart';
import 'shared/services/http_client_service.dart';
import 'shared/services/shared_local_storage_service.dart';
import 'splash/splash_screen.dart';
import 'viewmodel/change_theme_viewmodel.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.instance<Dio>(Dio()),
    Bind.instance<String>(Constants.urlApi),
    Bind.lazySingleton<IHttpClient>((i) => DioSevice(i(), i())),
    Bind.singleton<ILocalStorage>((i) => SharedLocalStorageService()),
    Bind.singleton((i) => ChangeThemeViewModel(i())),
    Bind.singleton((i) => AppController(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => const SplashScreen()),
    ModuleRoute(HomePage.id, module: HomeModule()),
  ];
}
