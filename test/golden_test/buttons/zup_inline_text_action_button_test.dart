import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/buttons/zup_inline_text_action_button.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({void Function()? onActionButtonPressed, TextStyle? textStyle}) async =>
      await goldenDeviceBuilder(
        Center(
          child: ZupInlineTextActionButton(
            text: "Some cool text",
            style: textStyle,
            actionButtonTitle: "Action Button",
            onActionButtonPressed: onActionButtonPressed ?? () {},
          ),
        ),
      );

  zGoldenTest("Zup inline action button", goldenFileName: "zup_inline_action_button", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    """When passing a custom style, the style should be applied to the text, and the button,
  except the button color, which should be the theme primary color""",
    goldenFileName: "zup_inline_action_button_custom_style",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          textStyle: const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w900, wordSpacing: 20),
        ),
      );
    },
  );

  zGoldenTest("When pressing the button, the callback should be called", (tester) async {
    bool callbackCalled = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onActionButtonPressed: () => callbackCalled = true));

    await tester.tap(find.byKey(const Key("zup-inline-action-button-button")).first);
    await tester.pumpAndSettle();

    expect(callbackCalled, true);
  });
}
