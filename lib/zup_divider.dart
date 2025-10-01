import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

class ZupDivider extends StatelessWidget {
  /// Show a divider from the Zup UI Kit
  const ZupDivider({super.key, this.color});

  /// Optionally pass a color to the divider line, otherwise it will use [ZupThemeColors.borderOnBackground]
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: Divider(color: color ?? ZupThemeColors.borderOnBackground.themed(context.brightness)),
    );
  }
}
