import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupDivider extends StatelessWidget {
  /// Show a divider from the Zup UI Kit
  const ZupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const FractionallySizedBox(
      widthFactor: 0.4,
      child: Divider(
        color: ZupColors.gray5,
      ),
    );
  }
}
