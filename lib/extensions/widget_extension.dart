import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_animated_hover.dart';

extension WidgetExtension on Widget {
  Widget animatedHover({ZupAnimatedHoverType type = ZupAnimatedHoverType.scale, double animationValue = 1.2}) {
    return ZupAnimatedHover(type: type, animationValue: animationValue, child: this);
  }
}
