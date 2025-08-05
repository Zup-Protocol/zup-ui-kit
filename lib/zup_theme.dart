import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Represents the theme of the Zup UI Kit
abstract class ZupTheme {
  static ThemeData get _defaultThemeData => ThemeData(
    scrollbarTheme: const ScrollbarThemeData(
      mainAxisMargin: 10,
      crossAxisMargin: 3,
      thickness: WidgetStatePropertyAll(5),
      thumbVisibility: WidgetStatePropertyAll(false),
    ),
  );

  /// Represents the light theme of the Zup UI Kit.
  ///
  /// Use this theme for light widgets
  static ThemeData get lightTheme => _defaultThemeData.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ZupThemeColors.background.lightColor,
    textTheme: _defaultThemeData.textTheme.apply(bodyColor: ZupThemeColors.primaryText.lightColor),
    scrollbarTheme: _defaultThemeData.scrollbarTheme.copyWith(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return ZupColors.gray;
        }

        return ZupColors.gray4;
      }),
    ),
  );

  /// Represents the dark theme of the Zup UI Kit.
  ///
  /// Use this theme for dark widgets
  static ThemeData get darkTheme => _defaultThemeData.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ZupThemeColors.background.darkColor,
    scrollbarTheme: _defaultThemeData.scrollbarTheme.copyWith(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return ZupColors.black5;
        }

        return ZupColors.black4;
      }),
    ),
    textTheme: _defaultThemeData.textTheme.apply(bodyColor: ZupThemeColors.primaryText.darkColor),
  );
}
