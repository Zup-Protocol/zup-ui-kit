import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/tags/zup_titled_value_tag.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({String? title, String? value, Widget? trailingIcon}) async =>
      await goldenDeviceBuilder(
        Center(
          child: ZupTitledValueTag(title: title ?? "Title", value: "Value", trailingIcon: trailingIcon),
        ),
      );

  zGoldenTest("Zup Titled Value Tag Default", goldenFileName: "zup_titled_value_tag", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    "When passing the trailing icon, it should be displayed after the value",
    goldenFileName: "zup_titled_value_tag_trailing_icon",
    (tester) async {
      return tester.pumpDeviceBuilder(
        await goldenBuilder(trailingIcon: const Icon(Icons.invert_colors_off, color: Colors.amber)),
      );
    },
  );
}
