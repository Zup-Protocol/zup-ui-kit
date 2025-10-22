import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Represents the colors of the Zup UI Kit
/// for dark and light widgets. In case of
/// needing the raw color, please use [ZupColors]
enum ZupThemeColors {
  /// Primary text color for your App.
  /// For example, a title of a page, or a paragraph.
  primaryText,

  /// Color for a disabled text, or a text that is not interactive
  /// neither primary. Can be used as secondary text as well.
  disabledText,

  /// The background color for a disabled button.
  disabledButtonBackground,

  /// The hover color that will be applied when some widget
  /// in the [background] color is hovered.
  hoverOnBackground,

  /// The hover color that will be applied when some widget
  /// in the [backgroundSurface] color is hovered.
  hoverOnBackgroundSurface,

  /// The surface color for the background. Mainly used
  /// in widgets that are on top of the [background]
  backgroundSurface,

  /// Splash color that will be applied when some widget
  /// in the [backgroundSurface] color is tapped.
  splashOnBackgroundSurface,

  /// Background color for a non primary or secondary button, a button
  /// that should not be the main focus in the screen, but
  /// should be clear that it is a button.
  tertiaryButtonBackground,

  /// Hover color that will be applied to the button used the
  /// [tertiaryButtonBackground]
  hoverOnTertiaryButton,

  /// A border color that can be applied on top of the [background] color
  /// and still be visible.
  borderOnBackground,

  /// A border color that can be applied on top of the [backgroundSurface] color
  /// and still be visible.
  borderOnBackgroundSurface,

  /// A Color to be used for icons in the UI
  iconColor,

  /// Splash color that will be applied when some widget
  /// in the [background] color is tapped.
  splashOnBackground,

  /// Splash color that will be applied when some widget
  /// in the [tertiaryButtonBackground] color is tapped.
  splashOnTertiaryButton,

  /// Color to be used for error widgets or states
  error,

  /// Color to be used for alert widgets or states
  alert,

  /// Color to be used for success widgets or states
  success,

  /// Color for the highlight of the shimmer effect.
  /// Note that it's not the background for the shimmer.
  shimmer,

  /// Inverse color of the [background] color
  backgroundInverse,

  /// The background color for the app screens, modals, etc...
  background;

  /// Returns the color based on the [brightness]
  ///
  /// In case of the [brightness] is [Brightness.light], the [lightColor] will be returned
  /// In case of the [brightness] is [Brightness.dark], the [darkColor] will be returned.
  ///
  /// Useful when dealing with dark and light themes. The Brightness can be obtained
  /// by using `context.brightness` (In case you are also using Zup Core). Or by using
  /// `Theme.of(context).brightness`
  Color themed(Brightness brightness) {
    if (brightness == Brightness.light) return lightColor;

    return darkColor;
  }

  /// Returns the light color for the current [ZupThemeColors]
  ///
  /// A light color is intended to be used for a light theme.
  Color get lightColor => switch (this) {
    ZupThemeColors.background => ZupColors.white,
    ZupThemeColors.primaryText => ZupColors.black,
    ZupThemeColors.disabledText => ZupColors.gray4,
    ZupThemeColors.backgroundSurface => ZupColors.white,
    ZupThemeColors.borderOnBackground => ZupColors.gray5,
    ZupThemeColors.hoverOnBackground => ZupColors.gray6,
    ZupThemeColors.iconColor => ZupColors.black,
    ZupThemeColors.splashOnBackground => ZupColors.gray5,
    ZupThemeColors.hoverOnBackgroundSurface => ZupColors.gray6,
    ZupThemeColors.tertiaryButtonBackground => ZupColors.gray6,
    ZupThemeColors.disabledButtonBackground => ZupColors.gray5,
    ZupThemeColors.hoverOnTertiaryButton => ZupColors.gray5.withValues(alpha: 0.4),
    ZupThemeColors.splashOnTertiaryButton => ZupColors.gray5.withValues(alpha: 0.8),
    ZupThemeColors.splashOnBackgroundSurface => ZupColors.gray5,
    ZupThemeColors.error => ZupColors.red,
    ZupThemeColors.borderOnBackgroundSurface => ZupColors.gray5,
    ZupThemeColors.alert => ZupColors.orange,
    ZupThemeColors.shimmer => ZupColors.gray5,
    ZupThemeColors.backgroundInverse => ZupColors.black,
    ZupThemeColors.success => ZupColors.green,
  };

  /// Returns the dark color for the current [ZupThemeColors]
  ///
  /// A dark color is intended to be used for a dark theme.
  Color get darkColor => switch (this) {
    ZupThemeColors.background => const Color.fromARGB(255, 17, 17, 17),
    ZupThemeColors.primaryText => ZupColors.gray4,
    ZupThemeColors.disabledText => ZupColors.black5,
    ZupThemeColors.backgroundSurface => ZupColors.black3,
    ZupThemeColors.borderOnBackground => ZupColors.black3,
    ZupThemeColors.hoverOnBackground => ZupColors.black3,
    ZupThemeColors.splashOnBackground => ZupColors.black4,
    ZupThemeColors.iconColor => ZupColors.white,
    ZupThemeColors.hoverOnBackgroundSurface => ZupColors.black4,
    ZupThemeColors.tertiaryButtonBackground => ZupColors.black3,
    ZupThemeColors.disabledButtonBackground => ZupColors.black4,
    ZupThemeColors.hoverOnTertiaryButton => ZupColors.black4,
    ZupThemeColors.splashOnTertiaryButton => ZupColors.black5,
    ZupThemeColors.splashOnBackgroundSurface => ZupColors.black5,
    ZupThemeColors.error => ZupColors.red3,
    ZupThemeColors.borderOnBackgroundSurface => ZupColors.black4,
    ZupThemeColors.alert => ZupColors.orange3,
    ZupThemeColors.shimmer => ZupColors.black5,
    ZupThemeColors.backgroundInverse => ZupColors.white,
    ZupThemeColors.success => ZupColors.green3,
  };
}
