import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({Offset? offset}) async => await goldenDeviceBuilder(Center(
        child: Builder(builder: (context) {
          return Container(
            color: Colors.yellow,
            child: TextButton(
              onPressed: () {
                ZupPopover.show(
                  adjustment: offset,
                  showBasedOnContext: context,
                  child: Container(
                    color: Colors.green,
                    child: const Text("popover CHild"),
                  ),
                );
              },
              child: const Text("Show popover"),
            ),
          );
        }),
      ));

  zGoldenTest("When callling .show in the zup popover, it should be displayed below the button",
      goldenFileName: "zup_popover", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
  });

  zGoldenTest(
    "When passing an offset, it should adjust the popover position by the offset passed",
    goldenFileName: "zup_popover_custom_offset",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(offset: const Offset(50, 100)));

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
    },
  );
}
