import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
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
    Duration? delay,
    EdgeInsetsGeometry? margin,
    bool isChildBounded = true,
    bool snapshotThemeModes = true,
  }) async => await goldenDeviceBuilder(
    snapshotThemeModes: snapshotThemeModes,
    ZupTooltip.text(
      margin: margin,
      isChildBounded: isChildBounded,
      delay: delay,
      message: message,
      constraints: BoxConstraints(maxWidth: maxWidth ?? 300),
      onHelperButtonPressed: helperButtonOnPressed,
      helperButtonTitle: helperButtonTitle,
      trailingIcon: trailingIcon,
      leadingIcon: leadingIcon,
      child: const Text(key: Key("tooltip_parent"), "Tooltip Child"),
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
      await tester.pumpDeviceBuilder(
        await goldenBuilder(isChildBounded: false, helperButtonTitle: " Helper Button", helperButtonOnPressed: () {}),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When setting the helper button on pressed, it should be called once pressed", (tester) async {
    int counter = 0;

    await tester.pumpDeviceBuilder(
      await goldenBuilder(
        isChildBounded: false,
        helperButtonOnPressed: () => counter++,
        helperButtonTitle: " Helper Button",
      ),
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

  zGoldenTest(
    "When using the text factory with a empty message, it should not show the tooltip on hover",
    goldenFileName: "zup_text_tooltip_empty_message_hover",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(message: ""));

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When setting the delay param in the text tooltip, it should not show the tooltip
    until the delay is over""",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(delay: const Duration(seconds: 1), snapshotThemeModes: false));

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, "zup_text_tooltip_delay_not_done");

      await tester.pump(const Duration(seconds: 2));

      await screenMatchesGolden(tester, "zup_text_tooltip_delay_done");
    },
  );

  zGoldenTest(
    """When setting the margin param in the text tooltip,
  it should create a margin between the child and the tooltip
  with the passed margin""",
    goldenFileName: "zup_text_tooltip_margin",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(margin: const EdgeInsets.only(top: 100, left: 50), snapshotThemeModes: false),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When setting the param isChildBounded true in the text tooltip, it should immediatly hide
  the tooltip if the hover goes outside of the child, even if it goes to the tooltip box""",
    goldenFileName: "zup_text_tooltip_is_child_bounded",
    (tester) async {
      const message =
          "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm";

      await tester.pumpDeviceBuilder(
        await goldenBuilder(isChildBounded: true, snapshotThemeModes: false, message: message),
      );

      final hoverGesture = await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
      await tester.moveHoverToWidget(find.text(message), hoverGesture);
    },
  );

  zGoldenTest(
    """When setting the param isChildBounded false in the text tooltip, it should not hide
    the tooltip if the user moves the hover to the tooltip box""",
    goldenFileName: "zup_text_tooltip_not_child_bounded",
    (tester) async {
      const message =
          "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm";

      await tester.pumpDeviceBuilder(
        await goldenBuilder(isChildBounded: false, snapshotThemeModes: false, message: message),
      );

      final hoverGesture = await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
      await tester.moveHoverToWidget(find.text(message), hoverGesture);
    },
  );

  zGoldenTest(
    """When setting the param isChildBounded false in the text tooltip, it should hide
    the tooltip if the user clicks anywhere in the screen, including the tooltip box""",
    goldenFileName: "zup_text_tooltip_not_child_bounded_click",
    (tester) async {
      const message =
          "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm";

      await tester.pumpDeviceBuilder(
        await goldenBuilder(isChildBounded: false, snapshotThemeModes: false, message: message),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(message));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When setting the param isChildBounded true in the text tooltip, it should not hide
    the tooltip if the user clicks in the tooltip parent""",
    goldenFileName: "zup_text_tooltip_child_bounded_parent_click",
    (tester) async {
      const message =
          "pitch leader probably action bark tried crack beginning origin hundred research tube object took arm";

      await tester.pumpDeviceBuilder(
        await goldenBuilder(isChildBounded: true, snapshotThemeModes: false, message: message),
      );

      await tester.hover(find.byType(ZupTooltip).first);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("tooltip_parent")));
      await tester.pumpAndSettle();
    },
  );
}
