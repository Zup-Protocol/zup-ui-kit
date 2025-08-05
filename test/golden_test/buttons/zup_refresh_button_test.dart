import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zup_ui_kit/buttons/zup_refresh_button.dart';

import '../../golden_config.dart';
import '../../mocks.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Color? iconColor,
    Future Function()? onPressed,
    double size = 20,
    AnimationController? animationController,
  }) async => await goldenDeviceBuilder(
    Center(
      child: ZupRefreshButton(
        iconColor: iconColor,
        animationController: animationController,
        size: size,
        onPressed: onPressed ?? () async {},
      ),
    ),
  );

  zGoldenTest("Zup Refresh Button Default", goldenFileName: "zup_refresh_button", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest(
    "When passing icon color to the zup refresh button, its color should change",
    goldenFileName: "zup_refresh_button_custom_icon_color",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(iconColor: Colors.green));
    },
  );

  zGoldenTest(
    "When passing a higher size to the zup refresh button, it should be applied",
    goldenFileName: "zup_refresh_button_size",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(size: 100));
    },
  );

  zGoldenTest("When callback the zup refresh button, it should start a animation in the repeat mode", (tester) async {
    final animationController = AnimationControllerMock();

    when(() => animationController.status).thenReturn(AnimationStatus.completed);
    when(() => animationController.value).thenReturn(0);
    when(() => animationController.repeat()).thenAnswer((_) => TickerFuture.complete());
    when(() => animationController.forward()).thenAnswer((_) => TickerFuture.complete());

    await tester.pumpDeviceBuilder(await goldenBuilder(animationController: animationController));
    await tester.tap(find.byKey(const Key("refresh-button")).first);
    await tester.pumpAndSettle();

    verify(() => animationController.repeat()).called(1);
  });

  zGoldenTest(
    "When clicking the zup refresh button, and the callback future finished, the animation should just be in forward mode",
    (tester) async {
      bool callbacked = false;
      final animationController = AnimationControllerMock();

      when(() => animationController.status).thenReturn(AnimationStatus.dismissed);
      when(() => animationController.value).thenReturn(0);
      when(() => animationController.repeat()).thenAnswer((_) => TickerFuture.complete());
      when(() => animationController.forward()).thenAnswer((_) => TickerFuture.complete());

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          animationController: animationController,
          onPressed: () async {
            callbacked = true;
            await Future.delayed(Duration.zero);
          },
        ),
      );

      await tester.tap(find.byKey(const Key("refresh-button")).first);
      await tester.pumpAndSettle();

      expect(callbacked, true);
      verify(() => animationController.forward()).called(1);
    },
  );

  zGoldenTest(
    "When disposing the button, if an animation controller is passed, the controller should not be disposed",
    (tester) async {
      final animationController = AnimationControllerMock();

      when(() => animationController.status).thenReturn(AnimationStatus.completed);
      when(() => animationController.value).thenReturn(0);

      await tester.pumpDeviceBuilder(await goldenBuilder(animationController: animationController));
      await tester.pumpAndSettle();

      await tester.pumpWidget(Container()); // Making the button dispose
      await tester.pumpAndSettle();

      verifyNever(() => animationController.dispose());
    },
  );

  zGoldenTest(
    """When the button is disposed,
  and there is not an animation controller passed on its builder,
  the controller should be disposed""",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());
      await tester.pumpAndSettle();

      final animateWidget = find.byType(Animate).first.evaluate().first.widget as Animate;

      await tester.pumpWidget(Container()); // Making the button dispose
      await tester.pumpAndSettle();

      expect(() => animateWidget.controller!.forward(), throwsAssertionError);
    },
  );
}
