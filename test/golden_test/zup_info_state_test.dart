import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/buttons/zup_primary_button.dart';
import 'package:zup_ui_kit/zup_info_state.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Widget icon = const Icon(Icons.add),
    String title = "Title",
    String? helpButtonTitle,
    Widget? helpButtonIcon,
    dynamic Function()? onHelpButtonTap,
    String? description,
    double iconSize = 140,
    double helpButtonSpacing = 5,
    double iconSpacing = 30,
  }) async =>
      await goldenDeviceBuilder(
        ZupInfoState(
          iconSpacing: iconSpacing,
          icon: icon,
          title: title,
          helpButtonTitle: helpButtonTitle,
          helpButtonIcon: helpButtonIcon,
          onHelpButtonTap: onHelpButtonTap,
          description: description,
          iconSize: iconSize,
          helpButtonSpacing: helpButtonSpacing,
        ),
      );

  zGoldenTest("Zup Info State Default", goldenFileName: "zup_info_state", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When setting the description, it should be displayed", goldenFileName: "zup_info_state_with_description",
      (tester) async {
    await tester.pumpDeviceBuilder(
      await goldenBuilder(description: "bla bla bla"),
    );
  });

  zGoldenTest("When setting the icon, it should be displayed", goldenFileName: "zup_info_state_with_custom_icon",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(icon: const Icon(Icons.abc_sharp)));
  });

  zGoldenTest("When setting the icon size, it should be displayed",
      goldenFileName: "zup_info_state_with_custom_icon_size", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(iconSize: 100));
  });

  zGoldenTest("When setting the help button title, the button should be displayed",
      goldenFileName: "zup_info_state_with_help_button_title", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(helpButtonTitle: "Help", onHelpButtonTap: () {}));
  });

  zGoldenTest("When setting the help button icon, the button should be displayed on hover",
      goldenFileName: "zup_info_state_with_help_button_icon", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      helpButtonIcon: const Icon(Icons.abc_sharp),
      helpButtonTitle: "Help",
    ));

    await tester.hover(find.byType(ZupPrimaryButton));

    await tester.pumpAndSettle();
  });

  zGoldenTest("When setting the help button spacing, it should be displayed",
      goldenFileName: "zup_info_state_custom_help_button_spacing", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(helpButtonSpacing: 200, helpButtonTitle: "Help"));
  });

  zGoldenTest("When clicking the help button, it should call the callback", (tester) async {
    bool tapped = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(
      helpButtonIcon: const Icon(Icons.abc_sharp),
      helpButtonTitle: "Help",
      onHelpButtonTap: () => tapped = true,
    ));

    await tester.tap(find.byType(ZupPrimaryButton));

    expect(tapped, true);
  });

  zGoldenTest(
    "When passing a icon spacing, it should be applied between the icon and the title",
    goldenFileName: "zup_info_state_custom_icon_spacing",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(iconSpacing: 400));
    },
  );
}
