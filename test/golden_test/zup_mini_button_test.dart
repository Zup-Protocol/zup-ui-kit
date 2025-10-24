import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/buttons/zup_mini_button.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    double? iconSize,
    Function()? onPressed,
    String? title,
    Widget? icon,
    bool? isSelected,
  }) async => await goldenDeviceBuilder(
    ZupMiniButton(
      iconSize: iconSize ?? 16,
      icon: icon,
      onPressed: onPressed != null ? (_) => onPressed() : null,
      title: title ?? "Title",
      isSelected: isSelected,
    ),
  );

  zGoldenTest(
    "When the onPressed is null, the button should be in the disabled state",
    goldenFileName: "zup_mini_button_disabled",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
    },
  );

  zGoldenTest(
    "When the onPressed is not null, it should be in the enabled state",
    goldenFileName: "zup_mini_button_enabled",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}));
    },
  );

  zGoldenTest(
    "When hovering the button, and it's enabled, the button should be in the hovered state",
    goldenFileName: "zup_mini_button_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () {}, title: "Hovered"));

      await tester.hover(find.byType(ZupMiniButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When hovering the button, and it's not enabled, the button should not be in the hovered state",
    goldenFileName: "zup_mini_button_hover_disabled",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null, title: "not hover state"));

      await tester.hover(find.byType(ZupMiniButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When setting the icon, it should be displayed", goldenFileName: "zup_mini_button_with_icon", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(icon: const Icon(Icons.add)));
  });

  zGoldenTest("When setting the icon size, it should be displayed", goldenFileName: "zup_mini_button_with_icon_size", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(iconSize: 50, icon: const Icon(Icons.place)));
  });

  zGoldenTest(
    "When setting the isSelected to true, it should keep the button in the selected state",
    goldenFileName: "zup_mini_button_selected",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(isSelected: true));
    },
  );
}
