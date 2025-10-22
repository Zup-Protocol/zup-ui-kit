import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:golden_toolkit/golden_toolkit.dart";
import 'package:meta/meta.dart';
import "package:zup_ui_kit/zup_theme.dart";

class GoldenConfig {
  static final pcDevice = [const Device(size: Size(1912, 1040), name: "pc")];
  static final smallSquareDevice = [const Device(size: Size(800, 800), name: "square")];

  static Future<Widget> builder(Widget child, {bool darkMode = false}) async {
    await loadAppFonts();

    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: darkMode ? ZupTheme.darkTheme : ZupTheme.lightTheme,
      home: Scaffold(body: Center(child: child)),
    );
  }
}

Future<DeviceBuilder> goldenDeviceBuilder(
  Widget child, {
  bool snapshotThemeModes = true,
  bool isDarkMode = false,
}) async {
  final deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: GoldenConfig.smallSquareDevice)
    ..addScenario(widget: await GoldenConfig.builder(child, darkMode: isDarkMode));

  if (snapshotThemeModes) deviceBuilder.addScenario(widget: await GoldenConfig.builder(child, darkMode: true));
  return deviceBuilder;
}

@isTest
void zGoldenTest(
  String description,
  Future<void> Function(WidgetTester tester) test, {
  String? goldenFileName,
  Uint8List? overrideMockedNetworkImage,
}) {
  return testGoldens(description, (tester) async {
    await test(tester);

    await tester.pumpAndSettle();

    if (goldenFileName != null) {
      try {
        await screenMatchesGolden(tester, goldenFileName);
      } catch (e) {
        if ((e as TestFailure).message!.contains("non-existent file")) {
          autoUpdateGoldenFiles = true;
          await screenMatchesGolden(tester, goldenFileName);
          autoUpdateGoldenFiles = false;

          // ignore: avoid_print
          print("Golden file not detected. Auto-generated golden file: $goldenFileName");

          return;
        }

        rethrow;
      }
    }
  });
}
