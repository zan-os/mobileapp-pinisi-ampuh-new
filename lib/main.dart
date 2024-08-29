import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp_pinisi_ampuh_new/core/constants/constant_color.dart';
import 'package:mobileapp_pinisi_ampuh_new/features/login/presentation/login_screen.dart';

import 'environemnt/env_loader_development.dart';

void main() async {
  await loadEnv();
  runApp(const _Application());
}

class _Application extends StatelessWidget {
  const _Application();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          AppColors.bluePrimary.value,
          const <int, Color>{
            50: AppColors.bluePrimary50,
            100: AppColors.bluePrimary100,
            200: AppColors.bluePrimary200,
            300: AppColors.bluePrimary300,
            400: AppColors.bluePrimary400,
            500: AppColors.bluePrimary500,
            600: AppColors.bluePrimary600,
            700: AppColors.bluePrimary700,
            800: AppColors.bluePrimary800,
            900: AppColors.bluePrimary900,
          },
        ),
        scaffoldBackgroundColor: AppColors.whiteBackgroundColor,
        dialogBackgroundColor: AppColors.whiteBackgroundColor,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(
          AppColors.bluePrimaryDark.value,
          const <int, Color>{
            50: AppColors.bluePrimaryDark50,
            100: AppColors.bluePrimaryDark100,
            200: AppColors.bluePrimaryDark200,
            300: AppColors.bluePrimaryDark300,
            400: AppColors.bluePrimaryDark400,
            500: AppColors.bluePrimaryDark500,
            600: AppColors.bluePrimaryDark600,
            700: AppColors.bluePrimaryDark700,
            800: AppColors.bluePrimaryDark800,
            900: AppColors.bluePrimaryDark900,
          },
        ),
        scaffoldBackgroundColor: AppColors.whiteBackgroundColor,
        dialogBackgroundColor: AppColors.whiteBackgroundColor,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return const MaterialApp(
          debugShowCheckedModeBanner: !kReleaseMode,
          home: LoginScreen(),
        );
      },
    );
  }
}
