import 'package:flutter/widgets.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

extension NumExtension on num {
  /// Returns a color representing the trend direction of a numeric value.
  ///
  /// The returned color depends on the sign of the number:
  ///
  ///  * **Positive values** return [ZupThemeColors.success], themed according to
  ///    the current [Brightness] from [context].
  ///  * **Negative values** return [ZupThemeColors.error], themed according to
  ///    the current [Brightness] from [context].
  ///  * **Zero** values return [ZupColors.gray].
  ///
  /// This method is typically used to visually represent numerical trends,
  /// such as price changes, yield rates, or balance variations in a UI.
  ///
  /// Example:
  ///
  /// ```dart
  /// final delta = -0.25;
  /// final color = delta.trendColor(context);
  /// // Returns a themed error color to indicate a negative trend.
  /// ```
  ///
  /// See also:
  ///
  ///  * [ZupThemeColors], for available theme-aware color definitions.
  ///  * [ZupColors], for static color constants.
  Color trendColor(BuildContext context) {
    if (this > 0) return ZupThemeColors.success.themed(context.brightness);
    if (this < 0) return ZupThemeColors.error.themed(context.brightness);

    return ZupColors.gray;
  }
}
