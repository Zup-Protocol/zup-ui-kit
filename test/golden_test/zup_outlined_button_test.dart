import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    required Function()? onPressed,
    Text? title,
    Widget? leadingIcon,
    Widget? trailingIcon,
    double leadingIconSpacing = 10,
    double trailingIconSpacing = 10,
    bool snapshotThemeModes = true,
    bool isDarkMode = false,
  }) async {
    return goldenDeviceBuilder(
      isDarkMode: isDarkMode,
      snapshotThemeModes: snapshotThemeModes,
      ZupOutlinedButton(
        onPressed: onPressed,
        title: title ?? const Text("Title"),
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        leadingIconSpacing: leadingIconSpacing,
        trailingIconSpacing: trailingIconSpacing,
      ),
    );
  }

  zGoldenTest(
    "When the onPressed is null, the button should be in the disabled state",
    goldenFileName: "zup_outlined_button_disabled",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(onPressed: null));
    },
  );

  zGoldenTest(
    "When hovering the button in light mode, it should show the hover state",
    goldenFileName: "zup_outlined_button_hover_light_mode",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: () {}, snapshotThemeModes: false, isDarkMode: false),
      );

      await tester.hover(find.byType(ZupOutlinedButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When hovering the button in dark mode, it should show the hover state",
    goldenFileName: "zup_outlined_button_hover_dark_mode",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(onPressed: () {}, snapshotThemeModes: false, isDarkMode: true),
      );

      await tester.hover(find.byType(ZupOutlinedButton).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When passing a leading icon, it should be at the left side of the title",
    goldenFileName: "zup_outlined_button_with_leading_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          leadingIcon: const Icon(Icons.add, color: Colors.green),
          title: const Text("Title"),
          onPressed: () {},
        ),
      );
    },
  );

  zGoldenTest(
    "When passing a trailing icon, it should be at the right side of the title",
    goldenFileName: "zup_outlined_button_with_trailing_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          trailingIcon: const Icon(Icons.ac_unit, color: Colors.green),
          title: const Text("Title"),
          onPressed: () {},
        ),
      );
    },
  );

  zGoldenTest(
    "When passing the leading icon spacing, it should be applied between the icon and the left side of the title",
    goldenFileName: "zup_outlined_button_with_leading_icon_spacing",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          leadingIconSpacing: 100,
          leadingIcon: const Icon(Icons.add, color: Colors.green),
          title: const Text("Title"),
          onPressed: () {},
        ),
      );
    },
  );

  zGoldenTest(
    "When passing the trailing icon spacing, it should be applied between the icon and the right side of the title",
    goldenFileName: "zup_outlined_button_with_trailing_icon_spacing",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          trailingIconSpacing: 100,
          trailingIcon: const Icon(Icons.accessibility_new_rounded, color: Colors.green),
          title: const Text("Title"),
          onPressed: () {},
        ),
      );
    },
  );

  zGoldenTest(
    "When passing a custom text style for the title, it should be applied to the title",
    goldenFileName: "zup_outlined_button_custom_title_style",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          title: const Text(
            "Title",
            style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        ),
      );
    },
  );
}
