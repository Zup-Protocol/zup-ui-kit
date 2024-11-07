import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_selectable_card.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String title = "Child",
    bool isSelected = false,
    EdgeInsetsGeometry? padding,
    Function()? onPressed,
  }) async =>
      await goldenDeviceBuilder(ZupSelectableCard(
        isSelected: isSelected,
        padding: padding ?? const EdgeInsets.all(20),
        onPressed: onPressed,
        child: Text(title),
      ));

  zGoldenTest("Zup Selectable Card Default", goldenFileName: "zup_selectable_card", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When setting the isSelected to true, it should be in the selected state",
      goldenFileName: "zup_selectable_card_selected", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder(title: "Selected", isSelected: true));
  });

  zGoldenTest("When setting the padding, it should be applied visually",
      goldenFileName: "zup_selectable_card_custom_padding", (tester) async {
    return tester
        .pumpDeviceBuilder(await goldenBuilder(title: "With Custom Padding", padding: const EdgeInsets.all(0)));
  });

  zGoldenTest("When pressing the card, the onPressed function should be called", (tester) async {
    bool pressed = false;
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => pressed = true));

    await tester.tap(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();

    expect(pressed, true);
  });

  zGoldenTest("When hovering the card, it should show the hover state", goldenFileName: "zup_selectable_card_hover",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(title: "Hovered"));

    await tester.hover(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();
  });
}
