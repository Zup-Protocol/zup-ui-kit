import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_snack_bar.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Widget? customIcon,
    bool hideCloseIcon = false,
    Duration snackDuration = const Duration(seconds: 5),
    ZupSnackBarType type = ZupSnackBarType.error,
    double maxWidth = double.infinity,
    String? message,
    ({dynamic Function() onButtonTap, String title})? helperButton,
  }) async =>
      await goldenDeviceBuilder(
        Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                ZupSnackBar(
                  context,
                  message: message ?? "message",
                  customIcon: customIcon,
                  hideCloseIcon: hideCloseIcon,
                  snackDuration: snackDuration,
                  type: type,
                  helperButton: helperButton,
                  maxWidth: maxWidth,
                ),
              ),
            );

            return const SizedBox.shrink();
          },
        ),
      );

  zGoldenTest("Zup Snack Bar Error", goldenFileName: "zup_snack_bar_error", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(type: ZupSnackBarType.error));
  });

  zGoldenTest("Zup Snack Bar Info", goldenFileName: "zup_snack_bar_info", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(type: ZupSnackBarType.info));
  });

  zGoldenTest("Zup Snack Bar Success", goldenFileName: "zup_snack_bar_success", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(type: ZupSnackBarType.success));
  });

  zGoldenTest("When setting a custom icon, the icon should be displayed -> Error type",
      goldenFileName: "zup_snack_bar_error_with_custom_icon", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(customIcon: const Icon(Icons.add), type: ZupSnackBarType.error));
  });

  zGoldenTest("When setting a custom icon, the icon should be displayed -> Info type",
      goldenFileName: "zup_snack_bar_info_with_custom_icon", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(customIcon: const Icon(Icons.add), type: ZupSnackBarType.info));
  });

  zGoldenTest("When setting a custom icon, the icon should be displayed -> Success type",
      goldenFileName: "zup_snack_bar_success_with_custom_icon", (tester) async {
    await tester.pumpDeviceBuilder(
      await goldenBuilder(customIcon: const Icon(Icons.add), type: ZupSnackBarType.success),
    );
  });

  zGoldenTest("When setting the show close icon to false, it should not show the close icon -> Error type",
      goldenFileName: "zup_snack_bar_error_no_close_icon", (tester) async {
    return tester.pumpDeviceBuilder(
      await goldenBuilder(
        hideCloseIcon: true,
        type: ZupSnackBarType.error,
      ),
    );
  });

  zGoldenTest("When setting the show close icon to false, it should not show the close icon -> Info type",
      goldenFileName: "zup_snack_bar_info_no_close_icon", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder(hideCloseIcon: true, type: ZupSnackBarType.info));
  });

  zGoldenTest("When setting the show close icon to false, it should not show the close icon -> Success type",
      goldenFileName: "zup_snack_bar_success_no_close_icon", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder(hideCloseIcon: true, type: ZupSnackBarType.success));
  });

  zGoldenTest(
      "When setting the max width lower than the screen, it should not expand the snack bar to the max available width",
      goldenFileName: "zup_snack_bar_max_width_set", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder(maxWidth: 200, type: ZupSnackBarType.success));
  });

  zGoldenTest(
    "When setting the Helper button param, a helper button should be displayed at the end of the snack bar message",
    goldenFileName: "zup_snack_bar_helper_button",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          message: "Helper butto test ",
          helperButton: (
            title: "Helper button title",
            onButtonTap: () {},
          ),
          type: ZupSnackBarType.success,
        ),
      );
    },
  );

  zGoldenTest(
    "When clickint the helper button of the snackBar, the callback should be called",
    (tester) async {
      bool callbackCalled = false;

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          message: "Helper butto test ",
          helperButton: (
            title: "Helper button title",
            onButtonTap: () => callbackCalled = true,
          ),
          type: ZupSnackBarType.success,
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("helper-button-snack-bar")));
      await tester.pumpAndSettle();

      expect(callbackCalled, true);
    },
  );
}
