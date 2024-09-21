import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/buttons/zup_primary_button.dart';

import '../../golden_config.dart';
import '../../helpers.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Color? backgroundColor,
    Color? foregroundColor,
    Widget? icon,
    BorderSide? border,
    bool isLoading = false,
    double hoverElevation = 14,
    bool fixedIcon = false,
    FontWeight? fontWeight,
    String? title,
    required dynamic Function()? onPressed,
    MainAxisSize mainAxisSize = MainAxisSize.min,
  }) async =>
      await goldenDeviceBuilder(
        ZupPrimaryButton(
          title: title ?? "Title",
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          icon: icon,
          border: border,
          isLoading: isLoading,
          hoverElevation: hoverElevation,
          fixedIcon: fixedIcon,
          fontWeight: fontWeight,
          mainAxisSize: mainAxisSize,
        ),
      );

  zGoldenTest("Zup Primary Button Default", goldenFileName: "zup_primary_button_default", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}));
  });

  zGoldenTest("When the `onPressed` is null, the button should be inactive",
      goldenFileName: "zup_primary_button_inactive", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
  });

  zGoldenTest("When clicking the button, the `onPressed` callback should be called", (tester) async {
    bool pressed = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => pressed = true));
    await tester.tap(find.byType(ZupPrimaryButton));
    await tester.pumpAndSettle();

    expect(pressed, true);
  });

  zGoldenTest("When setting a custom background color, the button color should change",
      goldenFileName: "zup_primary_button_custom_background_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, backgroundColor: Colors.pink));
  });

  zGoldenTest("When setting a custom foreground color, the button text color should change",
      goldenFileName: "zup_primary_button_custom_foreground_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, foregroundColor: Colors.pink));
  });

  zGoldenTest("When setting a custom icon, the icon should change", goldenFileName: "zup_primary_button_custom_icon",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, icon: const Icon(Icons.add), fixedIcon: true));
  });

  zGoldenTest("When setting a custom border, the border should change",
      goldenFileName: "zup_primary_button_custom_border", (tester) async {
    await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: () {}, border: const BorderSide(width: 5, color: Colors.pink)));
  });

  zGoldenTest("When setting a custom hover elevation, the hover elevation should change",
      goldenFileName: "zup_primary_button_custom_hover_elevation", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, hoverElevation: 5));

    await tester.hover(find.byType(ZupPrimaryButton));
    await tester.pumpAndSettle();
  });

  zGoldenTest("When setting a custom font weight, the font weight should change",
      goldenFileName: "zup_primary_button_custom_font_weight", (tester) async {
    const fontWeight = FontWeight.w900;
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, fontWeight: fontWeight));
  });

  zGoldenTest("When setting a custom main axis size, the main axis size should change",
      goldenFileName: "zup_primary_button_custom_main_axis_size", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, mainAxisSize: MainAxisSize.max));
  });

  zGoldenTest("When hovering the button, the icon should appear and the button should elevate",
      goldenFileName: "zup_primary_button_hover", (tester) async {
    await tester.pumpDeviceBuilder(
      await goldenBuilder(onPressed: () {}, icon: const Icon(Icons.add), fixedIcon: false),
    );

    await tester.hover(find.byType(ZupPrimaryButton));
    await tester.pumpAndSettle();
  });
}
