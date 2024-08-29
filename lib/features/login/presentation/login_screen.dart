import 'package:flutter/material.dart';

import '../../../core/constants/constant_color.dart';
import '../../../shared/utils/app_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: Text('Hellow'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_ChangeLanguageChip()],
          )
        ],
      ),
    );
  }
}

class _ChangeLanguageChip extends StatelessWidget {
  const _ChangeLanguageChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: AppColors.colorBgBtnLanguage,
      child: const Row(
        children: [Text('ID')],
      ),
    );
  }
}
