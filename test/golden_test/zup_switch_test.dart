import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_switch.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder(
          {bool value = true, double size = 40, required void Function(bool)? onChanged}) async =>
      await goldenDeviceBuilder(
        Center(
          child: ZupSwitch(
            value: value,
            onChanged: onChanged,
            size: size,
          ),
        ),
      );

  zGoldenTest("Zup switch default", goldenFileName: "zup_switch", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(onChanged: (_) {}));
  });

  zGoldenTest("When passing value false to the switch, it should be in off state", goldenFileName: "zup_switch_off",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(value: false, onChanged: (_) {}));
  });

  zGoldenTest("When clicking the switch, the onChanged callback should be called", (tester) async {
    bool callbackCalled = false;

    await tester.pumpDeviceBuilder(await goldenBuilder(onChanged: (_) => callbackCalled = true));
    await tester.tap(find.byType(ZupSwitch));
    await tester.pumpAndSettle();

    expect(callbackCalled, true);
  });

  zGoldenTest("When passing size 80 to the switch, it should be 80x80", goldenFileName: "zup_switch_size_80",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(size: 80, onChanged: (_) {}));
  });

  zGoldenTest(
    "When passing a null callback to the switch, and a value of false, it should be in the disabled state",
    goldenFileName: "zup_switch_disabled_off",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(value: false, onChanged: null));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When passing a null callback to the switch, and a value of true, it should be in the disabled state",
    goldenFileName: "zup_switch_disabled_on",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(value: true, onChanged: null));
      await tester.pumpAndSettle();
    },
  );
}
