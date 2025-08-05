import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_text_field.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    String? hintText,
    Function(String)? onChanged,
    bool snapshotDarkMode = true,
  }) async {
    await loadAppFonts();

    return await goldenDeviceBuilder(
      SizedBox(
        width: 200,
        child: ZupTextField(hintText: hintText, onChanged: onChanged),
      ),
      snapshotDarkMode: snapshotDarkMode,
    );
  }

  zGoldenTest("Zup text field default", goldenFileName: "zup_text_field", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When setting the hint text, it should be displayed", goldenFileName: "zup_text_field_with_hint_text", (
    tester,
  ) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(hintText: "Hint Text"));
  });

  zGoldenTest("When typing on the text field, it should callback with the typed text", (tester) async {
    String typedText = "";
    String expectedTypedText = "TestQUERY";

    await tester.pumpDeviceBuilder(await goldenBuilder(onChanged: (text) => typedText = text, snapshotDarkMode: false));
    await tester.enterText(find.byType(ZupTextField), expectedTypedText);
    await tester.pumpAndSettle();

    expect(typedText, expectedTypedText);
  });
}
