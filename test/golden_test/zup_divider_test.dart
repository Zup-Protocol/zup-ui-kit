import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_divider.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({Color? color}) async =>
      await goldenDeviceBuilder(Center(child: ZupDivider(color: color)));

  zGoldenTest("Zup divider", goldenFileName: "zup_divider", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    "When passing the color argument, the passed color should be applied",
    goldenFileName: "zup_divider_custom_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(color: Colors.blue));
    },
  );
}
