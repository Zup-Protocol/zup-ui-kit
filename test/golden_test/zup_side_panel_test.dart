import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_side_panel.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({bool isDarkMode = false}) async {
    return await goldenDeviceBuilder(
      snapshotThemeModes: false,
      isDarkMode: isDarkMode,
      Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ZupSidePanel.show(
              context,
              child: const SizedBox(width: 300, child: Center(child: Text("Side Panal Child"))),
            );
          });

          return const SizedBox();
        },
      ),
    );
  }

  zGoldenTest(
    """When callling .show in the zup side panel in light mode,
    it should show the side panel with the child in light mode""",
    goldenFileName: "zup_side_panel",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(isDarkMode: false));
    },
  );
}
