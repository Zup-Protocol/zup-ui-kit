import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_stepped_loading.dart';

import 'golden_config.dart';

void main() {
  final steps = [
    const ZupSteppedLoadingStep(title: "Step 1", description: "Step 1 description", icon: Icon(Icons.abc)),
    const ZupSteppedLoadingStep(title: "Step 2", description: "Step 2 description", icon: Icon(Icons.addchart)),
    const ZupSteppedLoadingStep(title: "Step 3", description: "Step 3 description", icon: Icon(Icons.ac_unit)),
    const ZupSteppedLoadingStep(title: "Step 4", description: "Step 3 description", icon: Icon(Icons.ac_unit)),
  ];

  Future<Widget> widget() => GoldenConfig.builder(
        ZupSteppedLoading(stepDuration: const Duration(seconds: 2), steps: steps),
      );

  testWidgets("When initializing the widget, the first step in the array should be displayed", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(await widget());
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final firstStep = (find.byType(ZupSteppedLoading).evaluate().first.widget as ZupSteppedLoading).steps.first;

      expect(firstStep.hashCode, steps.first.hashCode);
    });
  });
}
