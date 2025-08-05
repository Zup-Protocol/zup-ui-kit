import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_animated_hover.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    double? animationValue,
    ZupAnimatedHoverType type = ZupAnimatedHoverType.scale,
  }) async => await goldenDeviceBuilder(
    ZupAnimatedHover(type: type, animationValue: animationValue, child: const Text("Child")),
  );

  zGoldenTest(
    "When hovering the widget with the type of animation opacity, and the value of 0.5, it should be 50% transparent",
    goldenFileName: "zup_animated_hover_opacity",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(animationValue: 0.5, type: ZupAnimatedHoverType.opacity));

      await tester.hover(find.byType(ZupAnimatedHover).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When hovering the widget with the type of scale, and the value of 2, it should be 2x bigger",
    goldenFileName: "zup_animated_hover_scale_up",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(animationValue: 2, type: ZupAnimatedHoverType.scale));

      await tester.hover(find.byType(ZupAnimatedHover).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When hovering the widget with the type of scale, and the value of 0.5, it should be 50% smaller",
    goldenFileName: "zup_animated_hover_scale_down",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(animationValue: 0.5, type: ZupAnimatedHoverType.scale));

      await tester.hover(find.byType(ZupAnimatedHover).first);
      await tester.pumpAndSettle();
    },
  );
}
