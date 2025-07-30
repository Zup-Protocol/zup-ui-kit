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
    Function(bool value)? onHover,
    List<BoxShadow>? boxShadow,
  }) async => await goldenDeviceBuilder(
    ZupSelectableCard(
      isSelected: isSelected,
      padding: padding ?? const EdgeInsets.all(20),
      onPressed: onPressed,
      boxShadow: boxShadow,
      onHoverChanged: onHover,
      child: Text(title),
    ),
  );

  zGoldenTest("Zup Selectable Card Default", goldenFileName: "zup_selectable_card", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    "When setting the isSelected to true, it should be in the selected state",
    goldenFileName: "zup_selectable_card_selected",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(title: "Selected", isSelected: true));
    },
  );

  zGoldenTest(
    "When setting the padding, it should be applied visually",
    goldenFileName: "zup_selectable_card_custom_padding",
    (tester) async {
      return tester.pumpDeviceBuilder(
        await goldenBuilder(title: "With Custom Padding", padding: const EdgeInsets.all(0)),
      );
    },
  );

  zGoldenTest("When pressing the card, the onPressed function should be called", (tester) async {
    bool pressed = false;
    await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: () => pressed = true));

    await tester.tap(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();

    expect(pressed, true);
  });

  zGoldenTest("When hovering the card, it should show the hover state", goldenFileName: "zup_selectable_card_hover", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(title: "Hovered"));

    await tester.hover(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();
  });

  zGoldenTest("When hovering the card, it should callback the hover function with true", (tester) async {
    bool callbacked = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(title: "HOVER ME!", onHover: (value) => callbacked = value));

    await tester.hover(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();

    expect(callbacked, true);
  });

  zGoldenTest("When hovering the card out, it should callback the hover function with false", (tester) async {
    bool isHovering = true;

    await tester.pumpDeviceBuilder(await goldenBuilder(title: "UNHOVER ME!", onHover: (value) => isHovering = value));

    final hoverGesture = await tester.hover(find.byType(ZupSelectableCard));
    await tester.pumpAndSettle();
    await tester.unHover(hoverGesture);
    await tester.pumpAndSettle();

    expect(isHovering, false);
  });

  zGoldenTest(
    "When passing a list of box shadows, it should be applied",
    goldenFileName: "zup_selectable_card_box_shadows",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(boxShadow: [const BoxShadow(color: Colors.green, blurRadius: 10, spreadRadius: 10)]),
      );
    },
  );
}
