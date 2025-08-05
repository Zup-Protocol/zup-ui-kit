import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/buttons/zup_icon_button.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Widget? icon,
    Color? backgroundColor,
    Color? iconColor,
    BorderSide? border,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(6),
    bool? circle,
    double? minimumHeight,
    required void Function(BuildContext)? onPressed,
  }) async => await goldenDeviceBuilder(
    ZupIconButton(
      backgroundColor: backgroundColor,
      iconColor: iconColor,
      borderSide: border,
      padding: padding,
      icon: icon ?? const Icon(Icons.add),
      onPressed: onPressed,
      circle: circle ?? false,
      minimumHeight: minimumHeight,
    ),
  );

  zGoldenTest("Zup Icon Button default", goldenFileName: "zup_icon_button", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}));
  });

  zGoldenTest(
    "When setting the background color, the background color should change",
    goldenFileName: "zup_icon_button_custom_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, backgroundColor: Colors.red));
    },
  );

  zGoldenTest(
    "When setting the Icon color, the Icon color should change",
    goldenFileName: "zup_icon_button_custom_icon_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, iconColor: Colors.red));
    },
  );

  zGoldenTest("When setting the padding, the padding should change", goldenFileName: "zup_icon_button_custom_padding", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, padding: const EdgeInsets.all(50)));
  });

  zGoldenTest("When setting the icon, the icon should change", goldenFileName: "zup_icon_button_custom_icon", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, icon: const Icon(Icons.place)));
  });

  zGoldenTest(
    "When the on Pressed is null, it should be in inactive state",
    goldenFileName: "zup_icon_button_inactive",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
    },
  );

  zGoldenTest("When the button is pressed, it should callback", (tester) async {
    bool pressed = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) => pressed = true));
    await tester.tap(find.byType(ZupIconButton).first);

    expect(pressed, true);
  });

  zGoldenTest(
    "When setting the border side param, the border should change",
    goldenFileName: "zup_icon_button_custom_border",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          onPressed: (_) {},
          border: const BorderSide(color: Colors.red, width: 1),
        ),
      );
    },
  );

  zGoldenTest(
    "When passing the circle variable true, the button should be circular",
    goldenFileName: "zup_icon_button_circle",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, circle: true));
    },
  );

  zGoldenTest(
    "When passing the minimum height variable, the button should have the height set",
    goldenFileName: "zup_icon_button_minimum_height",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (_) {}, minimumHeight: 100));
    },
  );
}
