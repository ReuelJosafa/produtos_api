import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_controleller.dart';

class ChangeThemeIC extends StatelessWidget {
  const ChangeThemeIC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AppController>();

    return ValueListenableBuilder<bool>(
        valueListenable: controller.themeSwitch,
        builder: (context, isDark, child) {
          return IconButton(
              onPressed: () {
                controller.changeThemeViewModel.changeTheme(!isDark);
              },
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode));
        });
  }
}
