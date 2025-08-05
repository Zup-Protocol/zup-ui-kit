import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

class ZupDivider extends StatelessWidget {
  /// Show a divider from the Zup UI Kit
  const ZupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.4,
      child: Divider(color: ZupThemeColors.borderOnBackground.themed(context.brightness)),
    );
  }
}
