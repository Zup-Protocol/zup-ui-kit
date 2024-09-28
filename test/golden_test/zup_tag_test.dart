import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_tag.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String title = "Title",
    Color color = Colors.amber,
    bool applyColorToIcon = true,
    Widget icon = const Icon(Icons.add),
    double iconSize = 40,
    double iconSpacing = 5,
  }) =>
      goldenDeviceBuilder(
        ZupTag(
          title: title,
          color: color,
          applyColorToIcon: applyColorToIcon,
          icon: icon,
          iconSize: iconSize,
          iconSpacing: iconSpacing,
        ),
      );

  zGoldenTest("Zug Tag Default", goldenFileName: "zup_tag", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When setting the title, it should be displayed", goldenFileName: "zup_tag_custom_title", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(title: "Custom Title"));
  });

  zGoldenTest("When setting the color, it should be displayed", goldenFileName: "zup_tag_custom_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(color: Colors.red));
  });

  zGoldenTest("When setting the icon, it should be displayed", goldenFileName: "zup_tag_custom_icon", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(icon: const Icon(Icons.padding)));
  });

  zGoldenTest("When setting the icon size, it should be displayed", goldenFileName: "zup_tag_custom_icon_size",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
        iconSize: 5,
        icon: Container(
          color: Colors.blue,
        )));
  });

  zGoldenTest("When setting the icon spacing, it should be displayed", goldenFileName: "zup_tag_custom_icon_spacing",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      iconSpacing: 100,
      icon: Container(
        color: Colors.black,
      ),
    ));
  });
}
