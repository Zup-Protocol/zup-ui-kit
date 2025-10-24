import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/buttons/zup_text_button.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String? title,
    required Function()? onPressed,
    Widget? icon,
    bool alignLeft = true,
    bool applyColorsToIcon = true,
  }) async {
    return await goldenDeviceBuilder(
      ZupTextButton(
        onPressed: onPressed,
        label: title ?? 'Label',
        applyColorsToIcon: applyColorsToIcon,
        icon: icon,
        alignLeft: alignLeft,
      ),
    );
  }

  zGoldenTest("Zup Text Button Default", goldenFileName: "zup_text_button", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}));
  });

  zGoldenTest(
    "When the onPressed is null, it should be in the disabled state",
    goldenFileName: "zup_text_button_disabled",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
    },
  );

  zGoldenTest(
    "When the icon is not null, it should show the passed icon",
    goldenFileName: "zup_text_button_with_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(title: "Icon", onPressed: () {}, icon: const Icon(Icons.add)));
    },
  );

  zGoldenTest(
    "When the icon is not null, and the button is disabled, it should show the passed icon, but with disabled style",
    goldenFileName: "zup_text_button_with_icon_disabled",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(title: "Icon", onPressed: null, icon: const Icon(Icons.add)));
    },
  );

  zGoldenTest(
    "When the applyColorsToIcon is false, it should keep the icon color as it is",
    goldenFileName: "zup_text_button_different_icon_color",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          title: "Icon",
          onPressed: () {},
          icon: const Icon(Icons.add, color: Colors.redAccent),
          applyColorsToIcon: false,
        ),
      );
    },
  );

  zGoldenTest(
    "When the alignLeft is false, it should not change the button offset",
    goldenFileName: "zup_text_button_align_left_disabled",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, alignLeft: false));
    },
  );

  zGoldenTest("When hovering the button, it should be in the hovered state", goldenFileName: "zup_text_button_hover", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, title: "Hovered"));

    await tester.hover(find.byType(ZupTextButton).first);
    await tester.pumpAndSettle();
  });

  zGoldenTest(
    "When hovering the button, and it has an Icon, it should resize the icon",
    goldenFileName: "zup_text_button_hover_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: () {}, title: "Hovered", icon: const Icon(Icons.add)),
      );

      await tester.hover(find.byType(ZupTextButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When clicking the button, it should be in the pressed state", (tester) async {
    bool pressed = false;
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => pressed = true, title: "Pressed"));

    await tester.tap(find.byType(ZupTextButton).first);
    await tester.pumpAndSettle();

    expect(pressed, true);
  });
}
