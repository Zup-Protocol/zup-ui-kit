import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:golden_toolkit/golden_toolkit.dart";
import 'package:meta/meta.dart';

class GoldenConfig {
  static final pcDevice = [const Device(size: Size(1912, 1040), name: "pc")];
  static final smallSquareDevice = [const Device(size: Size(800, 800), name: "square")];

  static Future<Widget> builder(Widget child) async {
    await loadAppFonts();

    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }
}

Future<DeviceBuilder> goldenDeviceBuilder(Widget child) async => DeviceBuilder()
  ..overrideDevicesForAllScenarios(devices: GoldenConfig.smallSquareDevice)
  ..addScenario(widget: await GoldenConfig.builder(child));

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
