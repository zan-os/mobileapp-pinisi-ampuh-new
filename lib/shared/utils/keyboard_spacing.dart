import 'package:flutter/widgets.dart';

import 'app_media_query.dart';

/// A widget that is used to fill the space between the keyboard and the bottom of
/// the screen.
class KeyboardSpacing extends StatelessWidget {
  final Color? color;

  const KeyboardSpacing({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppMediaQuery().keyboardHeight,
        builder: (_, child) {
          return Container(
            color: color ?? const Color(0x00000000),
            height: AppMediaQuery().keyboardHeight.height,
          );
        });
  }
}
