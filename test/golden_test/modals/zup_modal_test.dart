import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/modals/zup_modal.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    bool dismissible = true,
    Size size = const Size(500, 500),
    String? title,
    String? description,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) async =>
      await goldenDeviceBuilder(Builder(builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) => ZupModal.show(context,
            backgroundColor: backgroundColor,
            description: description,
            dismissible: dismissible,
            padding: padding,
            size: size,
            title: title,
            content: Container(
              height: 500,
              width: 500,
              color: Colors.green,
            )));

        return const SizedBox.shrink();
      }));

  zGoldenTest("Zup Modal Default", goldenFileName: "zup_modal", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When adding a title, the title should be displayed", goldenFileName: "zup_modal_with_title",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(title: "Title"));
  });

  zGoldenTest("When adding a description, but not the title, the description should not be displayed",
      goldenFileName: "zup_modal_without_description", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(description: "bla bla bla"));
  });

  zGoldenTest("When adding a description and title, the description should be displayed",
      goldenFileName: "zup_modal_with_description", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(description: "bla bla bla", title: "Bla"));
  });

  zGoldenTest("When adding a background color, the background color should be displayed",
      goldenFileName: "zup_modal_with_background_color", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(backgroundColor: Colors.red));
  });

  zGoldenTest("When adding a padding, the padding should be displayed", goldenFileName: "zup_modal_with_padding",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(padding: const EdgeInsets.all(50)));
  });

  zGoldenTest("When changing the size, the size should change", goldenFileName: "zup_modal_with_custom_size",
      (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(size: const Size(800, 800)));
  });
}
