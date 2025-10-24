import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// Show a circular loading indicator from the Zup UI Kit.
///
/// Similar to [CircularProgressIndicator] but with some adaptations
class ZupCircularLoadingIndicator extends StatelessWidget {
  /// Show a circular loading indicator from the Zup UI Kit.
  ///
  /// Similar to [CircularProgressIndicator] but with some adaptations
  const ZupCircularLoadingIndicator({super.key, this.trackColor, this.indicatorColor, required this.size});

  /// Optionally change the track color, the part that the indicator is on, defaults
  /// to [ZupColors.gray5] for light themes and [ZupColors.black4] for dark themes
  final Color? trackColor;

  /// Optionally change the indicator color, the rotating part, defaults to primary color of the theme
  final Color? indicatorColor;

  /// The size of the circular loading indicator widget, required to be passed.
  ///
  /// This size will be used as both the width and height of the widget.
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: (!kIsWeb && Platform.environment.containsKey('FLUTTER_TEST')) ? 0.5 : null,
        strokeWidth: size / 20,
        backgroundColor: trackColor ?? (context.brightness.isDark ? ZupColors.black4 : ZupColors.gray5),
        color: indicatorColor ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
