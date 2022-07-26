import 'package:flutter/material.dart';

import 'viewmodel/change_theme_viewmodel.dart';

class AppController {
  final ChangeThemeViewModel changeThemeViewModel;

  AppController(this.changeThemeViewModel) {
    changeThemeViewModel.init();
  }

  bool get isDark => changeThemeViewModel.config.themeSwitch.value;
  ValueNotifier<bool> get themeSwitch =>
      changeThemeViewModel.config.themeSwitch;
}
