import 'package:flutter/src/widgets/basic.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_divider.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder() async => await goldenDeviceBuilder(const Center(child: ZupDivider()));

  zGoldenTest("Zup divider", goldenFileName: "zup_divider", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });
}
