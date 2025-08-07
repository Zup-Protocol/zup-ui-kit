import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_tooltip.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String message = "Bla bla bla",
    Widget? trailingIcon,
    Widget? leadingIcon,
    double? maxWidth,
    Function()? helperButtonOnPressed,
    String? helperButtonTitle,
  }) async => await goldenDeviceBuilder(
    ZupTooltip.text(
      message: message,
      constraints: BoxConstraints(maxWidth: maxWidth ?? 300),
      helperButtonOnPressed: helperButtonOnPressed,
      helperButtonTitle: helperButtonTitle,
      trailingIcon: trailingIcon,
      leadingIcon: leadingIcon,
      child: const Text("Tooltip Child"),
    ),
  );

  zGoldenTest(
    "When not hovering the tooltip child, it should not show any tooltip message",
    goldenFileName: "zup_tooltip_not_hovered",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());
    },
  );

  zGoldenTest(
    "When hovering the tooltip child, it should show the tooltip message",
    goldenFileName: "zup_tooltip_hovered",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the leading icon, it should be applied visually on hover",
    goldenFileName: "zup_tooltip_with_leading_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(leadingIcon: const Icon(Icons.add)));

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the trailing icon, it should be applied visually on hover",
    goldenFileName: "zup_tooltip_with_trailing_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(trailingIcon: const Icon(Icons.add)));

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the helper button title, it should be displayed on hover",
    goldenFileName: "zup_tooltip_with_helper_button",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(helperButtonTitle: " Helper Button"));

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When setting the helper button on pressed, it should be called once pressed", (tester) async {
    int counter = 0;
    await tester.pumpDeviceBuilder(
      await goldenBuilder(helperButtonOnPressed: () => counter++, helperButtonTitle: " Helper Button"),
    );

    await tester.hover(find.byType(ZupTooltip).first);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key("helper-button-tooltip")).first);
    await tester.pumpAndSettle();

    expect(counter, 1);
  });

  zGoldenTest(
    "When the text is long, but the max width is less than the text, it should wrap the text",
    goldenFileName: "zup_tooltip_long_text_short_max_width",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          maxWidth: 100,
          message:
              "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm castle sun particularly studied usual middle matter pan leg",
        ),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When the text is long and the max width is greater than the text, it should go to the max width before wrapping the text",
    goldenFileName: "zup_tooltip_long_text_long_max_width",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          maxWidth: 1000,
          message:
              "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm",
        ),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When clicking the tooltip child, it should also show the tooltip", goldenFileName: "zup_tooltip_click", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());

    await tester.tap(find.byType(ZupTooltip).first);
    await tester.pumpAndSettle();
  });
  zGoldenTest(
    "When using the widget factory of the tooltip, it should show the passed widget when hovering the child",
    goldenFileName: "zup_tooltip_widget_factory",
    (tester) async {
      final customBuilder = await goldenDeviceBuilder(
        ZupTooltip.widget(
          tooltipChild: Container(height: 200, width: 100, color: Colors.greenAccent),
          child: const Text("HOVER ME!"),
        ),
      );

      await tester.pumpDeviceBuilder(customBuilder);

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );
}
