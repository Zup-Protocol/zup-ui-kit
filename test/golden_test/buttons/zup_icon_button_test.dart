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
    required dynamic Function()? onPressed,
  }) async =>
      await goldenDeviceBuilder(
        ZupIconButton(
          backgroundColor: backgroundColor,
          iconColor: iconColor,
          borderSide: border,
          padding: padding,
          icon: icon ?? const Icon(Icons.add),
          onPressed: onPressed,
        ),
      );

  zGoldenTest("Zup Icon Button default", goldenFileName: "zup_icon_button", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}));
  });

  zGoldenTest("When setting the background color, the background color should change",
      goldenFileName: "zup_icon_button_custom_background_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, backgroundColor: Colors.red));
  });

  zGoldenTest("When setting the Icon color, the Icon color should change",
      goldenFileName: "zup_icon_button_custom_icon_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, iconColor: Colors.red));
  });

  zGoldenTest("When setting the padding, the padding should change", goldenFileName: "zup_icon_button_custom_padding",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, padding: const EdgeInsets.all(50)));
  });

  zGoldenTest("When setting the icon, the icon should change", goldenFileName: "zup_icon_button_custom_icon",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, icon: const Icon(Icons.place)));
  });

  zGoldenTest("When the on Pressed is null, it should be in inactive state", goldenFileName: "zup_icon_button_inactive",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
  });

  zGoldenTest("When the button is pressed, it should callback", (tester) async {
    bool pressed = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => pressed = true));
    await tester.tap(find.byType(ZupIconButton));

    expect(pressed, true);
  });

  zGoldenTest("When setting the border side param, the border should change",
      goldenFileName: "zup_icon_button_custom_border", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      onPressed: () {},
      border: const BorderSide(color: Colors.red, width: 1),
    ));
  });
}
