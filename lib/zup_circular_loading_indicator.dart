import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

class ZupCircularLoadingIndicator extends StatelessWidget {
  const ZupCircularLoadingIndicator({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    required this.size,
  });

  final Color? backgroundColor;
  final Color? indicatorColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: Platform.environment.containsKey('FLUTTER_TEST') ? 0.5 : null,
        strokeWidth: size / 13,
        backgroundColor: (backgroundColor ?? ZupColors.gray5).withOpacity(0.2),
        color: (indicatorColor ?? ZupColors.gray),
      ),
    );
  }
}
