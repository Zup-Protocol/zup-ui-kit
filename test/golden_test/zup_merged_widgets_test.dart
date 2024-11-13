import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_merged_widgets.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({Widget? firstWidget, Widget? secondWidget}) async =>
      await goldenDeviceBuilder(ZupMergedWidgets(
        firstWidget: firstWidget ?? const Text("First"),
        secondWidget: secondWidget ?? const Text("Second"),
      ));

  zGoldenTest("Zup merged widgets with text", goldenFileName: "zup_merged_widgets_text", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      firstWidget: const Text("First"),
      secondWidget: const Text("Second"),
    ));
  });

  zGoldenTest("Zup merged widgets with containers", goldenFileName: "zup_merged_widgets_container", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      firstWidget: Container(color: Colors.deepPurpleAccent, height: 50, width: 50),
      secondWidget: Container(color: Colors.deepOrangeAccent, height: 50, width: 50),
    ));
  });
}
