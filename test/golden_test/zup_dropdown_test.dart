import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder() async => await goldenDeviceBuilder(Center(
        child: Builder(builder: (context) {
          return Container(
            color: Colors.yellow,
            child: TextButton(
              onPressed: () {
                ZupDropdown.show(
                  showBelowContext: context,
                  child: Container(
                    color: Colors.green,
                    child: const Text("Dropdown CHild"),
                  ),
                );
              },
              child: const Text("Show dropdown"),
            ),
          );
        }),
      ));

  zGoldenTest("When callling .show in the zup dropdown, it should be displayed below the button",
      goldenFileName: "zup_dropdown", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
  });
}
