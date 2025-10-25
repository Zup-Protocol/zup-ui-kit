import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_animated_hover.dart';

extension WidgetExtension on Widget {
  /// Adds a hover animation effect to the widget.
  ///
  /// When hovered, the widget animates based on the specified [type] and [animationValue].
  /// This provides an easy way to make widgets feel interactive and responsive in
  /// desktop and web environments.
  ///
  /// The default [type] is [ZupAnimatedHoverType.scale], and the default [animationValue]
  /// is `1.2`, which scales the widget up by 20% when hovered.
  ///
  /// Example:
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Container(
  ///     width: 100,
  ///     height: 100,
  ///     color: Colors.blue,
  ///   ).animatedHover(
  ///     type: ZupAnimatedHoverType.scale,
  ///     animationValue: 1.2,
  ///   );
  /// }
  /// ```
  ///
  /// See also:
  ///
  ///  * [ZupAnimatedHover], the widget that implements the hover animation.
  ///  * [ZupAnimatedHoverType], which defines available animation types.
  Widget animatedHover({ZupAnimatedHoverType type = ZupAnimatedHoverType.scale, double animationValue = 1.2}) {
    return ZupAnimatedHover(type: type, animationValue: animationValue, child: this);
  }
}
