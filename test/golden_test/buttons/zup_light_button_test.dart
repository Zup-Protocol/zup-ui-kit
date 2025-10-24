import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/buttons/zup_light_button.dart';
import 'package:zup_ui_kit/zup_colors.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Color restColor = ZupColors.gray4,
    Color hoverColor = ZupColors.black,
    void Function()? onPressed,
  }) async => await goldenDeviceBuilder(
    Center(
      child: ZupLightButton(
        restColor: restColor,
        hoverColor: hoverColor,
        onPressed: onPressed ?? () {},
        child: const Text("Button Child"),
      ),
    ),
  );
  zGoldenTest(
    "When the button is not hovered, and a rest color is not passed, it should be in the default rest color, which is gray",
    goldenFileName: "zup_light_button_default",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());
    },
  );

  zGoldenTest(
    "When hovering the button without passing a hover color, it should be use the default hover color, which is black",
    goldenFileName: "zup_light_button_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());

      await tester.hover(find.byType(ZupLightButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When passing a rest color, it should be the default color when the button is not hovered",
    goldenFileName: "zup_light_button_custom_rest",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(restColor: ZupColors.green));
    },
  );

  zGoldenTest(
    "When passing a hover color, it should be the default color when the button is hovered",
    goldenFileName: "zup_light_button_custom_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(hoverColor: ZupColors.green));

      await tester.hover(find.byType(ZupLightButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When clicking the button, the onPressed callback should be called", (tester) async {
    bool callbackCalled = false;
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => callbackCalled = true));

    await tester.tap(find.byType(ZupLightButton).first);
    await tester.pumpAndSettle();

    expect(callbackCalled, true);
  });
}
