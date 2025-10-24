import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/buttons/zup_primary_button.dart';

import '../../golden_config.dart';

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
    double height = 50,
    required dynamic Function(BuildContext buttonContext)? onPressed,
    EdgeInsets padding = const EdgeInsets.all(20),
    MainAxisSize mainAxisSize = MainAxisSize.min,
    bool isTrailingIcon = false,
  }) async => await goldenDeviceBuilder(
    ZupPrimaryButton(
      title: title ?? "Title",
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      icon: icon,
      border: border,
      isLoading: isLoading,
      height: height,
      hoverElevation: hoverElevation,
      fixedIcon: fixedIcon,
      padding: padding,
      fontWeight: fontWeight,
      mainAxisSize: mainAxisSize,
      isTrailingIcon: isTrailingIcon,
    ),
  );

  zGoldenTest("Zup Primary Button Default", goldenFileName: "zup_primary_button_default", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}));
  });

  zGoldenTest(
    "When the `onPressed` is null, the button should be inactive",
    goldenFileName: "zup_primary_button_inactive",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
    },
  );

  zGoldenTest("When clicking the button, the `onPressed` callback should be called", (tester) async {
    bool pressed = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) => pressed = true));
    await tester.tap(find.byType(ZupPrimaryButton).first);
    await tester.pumpAndSettle();

    expect(pressed, true);
  });

  zGoldenTest(
    "When setting a custom background color, the button color should change",
    goldenFileName: "zup_primary_button_custom_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}, backgroundColor: Colors.pink));
    },
  );

  zGoldenTest(
    "When setting a custom foreground color, the button text color should change",
    goldenFileName: "zup_primary_button_custom_foreground_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}, foregroundColor: Colors.pink));
    },
  );

  zGoldenTest("When setting a custom icon, the icon should change", goldenFileName: "zup_primary_button_custom_icon", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(
      await goldenBuilder(onPressed: (buttonContext) {}, icon: const Icon(Icons.add), fixedIcon: true),
    );
  });

  zGoldenTest(
    "When setting a custom border, the border should change",
    goldenFileName: "zup_primary_button_custom_border",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          onPressed: (buttonContext) {},
          border: const BorderSide(width: 5, color: Colors.pink),
        ),
      );
    },
  );

  zGoldenTest(
    "When setting a custom hover elevation, the hover elevation should change",
    goldenFileName: "zup_primary_button_custom_hover_elevation",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}, hoverElevation: 5));

      await tester.hover(find.byType(ZupPrimaryButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting a custom font weight, the font weight should change",
    goldenFileName: "zup_primary_button_custom_font_weight",
    (tester) async {
      const fontWeight = FontWeight.w900;
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}, fontWeight: fontWeight));
    },
  );

  zGoldenTest(
    "When setting a custom main axis size, the main axis size should change",
    goldenFileName: "zup_primary_button_custom_main_axis_size",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: (buttonContext) {}, mainAxisSize: MainAxisSize.max),
      );
    },
  );

  zGoldenTest(
    "When hovering the button, the icon should appear and the button should elevate",
    goldenFileName: "zup_primary_button_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: (buttonContext) {}, icon: const Icon(Icons.add), fixedIcon: false),
      );

      await tester.hover(find.byType(ZupPrimaryButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting a custom padding, it should change the button padding",
    goldenFileName: "zup_primary_button_custom_padding",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: (buttonContext) {}, padding: const EdgeInsets.all(1), height: 20),
      );
    },
  );

  zGoldenTest(
    "When the param isLoading is true, the button should show a loading indicator",
    goldenFileName: "zup_primary_button_loading",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: (buttonContext) {}, isLoading: true));
    },
  );

  zGoldenTest(
    "When passing 'isTrailing' icon as true and the fixedIcon is true, the icon passed to the button should be trailing",
    goldenFileName: "zup_primary_button_trailing_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          onPressed: (buttonContext) {},
          isTrailingIcon: true,
          fixedIcon: true,
          icon: const Icon(Icons.add),
        ),
      );
    },
  );

  zGoldenTest(
    "When passing 'isTrailing' icon as true and the fixedIcon is false, the icon passed to the button should be trailing when hovered",
    goldenFileName: "zup_primary_button_trailing_icon_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          onPressed: (buttonContext) {},
          isTrailingIcon: true,
          fixedIcon: true,
          icon: const Icon(Icons.add),
        ),
      );

      await tester.hover(find.byType(ZupPrimaryButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When loading and 'isTrailing' is true, the loading icon should be trailing",
    goldenFileName: "zup_primary_button_loading_trailing",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: (buttonContext) {}, isLoading: true, isTrailingIcon: true),
      );
    },
  );
}
