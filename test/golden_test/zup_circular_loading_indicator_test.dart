import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_circular_loading_indicator.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({double size = 20, Color? backgroundColor, Color? indicatorColor}) async =>
      await goldenDeviceBuilder(
        Center(
          child: ZupCircularLoadingIndicator(size: size, trackColor: backgroundColor, indicatorColor: indicatorColor),
        ),
      );

  zGoldenTest("Zup circular loading indicator default", goldenFileName: "zup_circular_loading_indicator_default", (
    tester,
  ) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    "When passing a higher size to the widget, it should be applied",
    goldenFileName: "zup_circular_loading_indicator_size",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(size: 100));
    },
  );

  zGoldenTest(
    "When changing the indicator color, it should be applied",
    goldenFileName: "zup_circular_loading_indicator_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(indicatorColor: Colors.red));
    },
  );

  zGoldenTest(
    "When changing the background color, it should be applied",
    goldenFileName: "zup_circular_loading_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(backgroundColor: Colors.red));
    },
  );
}
