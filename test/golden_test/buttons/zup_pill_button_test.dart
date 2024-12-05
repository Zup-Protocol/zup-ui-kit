import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/buttons/zup_pill_button.dart';
import 'package:zup_ui_kit/zup_colors.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String? title = "Title",
    Widget? icon = const Icon(Icons.add),
    Color? backgroundColor,
    Color? foregroundColor,
    Function(BuildContext buttonContext)? onPressed,
  }) async =>
      await goldenDeviceBuilder(Center(
          child: ZupPillButton(
        onPressed: onPressed ?? (buttonContext) {},
        title: title,
        icon: icon,
        backgroundColor: backgroundColor ?? ZupColors.brand7,
        foregroundColor: foregroundColor ?? ZupColors.brand,
      )));

  zGoldenTest(
    "When not passing either icon and title to the button, it should assert",
    (tester) async {
      expect(
        () async => await tester.pumpDeviceBuilder(await goldenBuilder(icon: null, title: null)),
        throwsAssertionError,
      );
    },
  );

  zGoldenTest(
    """When passing only an icon to the button,
    it should use the passed background color in
    the background of the icon, and the foreground color
    in the icon itself""",
    goldenFileName: "zup_pill_button_only_icon_with_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          icon: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: null,
        ),
      );
    },
  );

  zGoldenTest(
    """When passing only a title to the button,
    it should use the passed background color in
    the background of the button, and the foreground color
    in the title itself""",
    goldenFileName: "zup_pill_button_only_title_with_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          icon: null,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: "Title",
        ),
      );
    },
  );

  zGoldenTest(
    "When it's passed only an icon to the button, when pressing the button, it should callback",
    (tester) async {
      bool hasBeenCalled = false;

      await tester.pumpDeviceBuilder(await goldenBuilder(
        icon: const Icon(Icons.add),
        onPressed: (buttonContext) {
          hasBeenCalled = true;
        },
      ));
      await tester.tap(find.byType(ZupPillButton));
      await tester.pumpAndSettle();

      expect(hasBeenCalled, true);
    },
  );

  zGoldenTest(
    "When it's passed only a title to the button, when pressing the button, it should callback",
    (tester) async {
      bool hasBeenCalled = false;

      await tester.pumpDeviceBuilder(await goldenBuilder(
        title: "dale",
        onPressed: (buttonContext) {
          hasBeenCalled = true;
        },
      ));
      await tester.tap(find.byType(ZupPillButton));
      await tester.pumpAndSettle();

      expect(hasBeenCalled, true);
    },
  );

  zGoldenTest(
    "The context passed in the onPressed function should be the button context",
    (tester) async {
      BuildContext? receivedButtonContext;

      await tester.pumpDeviceBuilder(await goldenBuilder(
        title: "dale",
        onPressed: (buttonContext) {
          receivedButtonContext = buttonContext;
        },
      ));
      await tester.tap(find.byType(ZupPillButton));
      await tester.pumpAndSettle();

      expect(
        receivedButtonContext!.widget,
        find.byType(ZupPillButton).first.evaluate().first.widget,
      );
    },
  );
}
