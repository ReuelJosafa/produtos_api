import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controleller.dart';
import 'app_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Modular.isModuleReady<AppModule>();
    return ValueListenableBuilder<bool>(
      valueListenable: Modular.get<AppController>().themeSwitch,
      builder: (context, isDart, child) {
        return MaterialApp.router(
          title: 'Products APP',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: isDart ? Brightness.dark : Brightness.light,
          ),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
        );
      },
    );
  }
}
