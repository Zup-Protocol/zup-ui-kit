import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/buttons/buttons.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    Widget? restIcon,
    Widget? pressedIcon,
    Color? backgroundColor,
    bool? circle,
    EdgeInsetsGeometry? padding,
    Duration? pressedIconDuration,
    String? pressedIconTooltipMessage,
    String? restIconTooltipMessage,
    Function(BuildContext context)? onPressed,
    bool snapshotThemeModes = true,
  }) => goldenDeviceBuilder(
    snapshotThemeModes: snapshotThemeModes,
    ZupSwitchingIconButton(
      padding: padding,
      pressedIconDuration: pressedIconDuration,
      pressedIconTooltipMessage: pressedIconTooltipMessage,
      restIconTooltipMessage: restIconTooltipMessage,
      backgroundColor: backgroundColor,
      circle: circle ?? true,
      restIcon: restIcon ?? const Icon(Icons.place, color: Colors.orange),
      pressedIcon: pressedIcon ?? const Icon(Icons.close, color: Colors.green),
      onPressed: onPressed ?? (buttonContext) {},
    ),
  );

  zGoldenTest(
    "When the button is not clicked, it should be with the rest icon",
    goldenFileName: "zup_switching_icon_button_rest_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(restIcon: const Icon(Icons.place, color: Colors.green)));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When the button is clicked, it should change to the pressed icon",
    goldenFileName: "zup_switching_icon_button_pressed_icon",
    (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(await goldenBuilder(pressedIcon: const Icon(Icons.ac_unit, color: Colors.blue)));
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ZupSwitchingIconButton).first); // light mode
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ZupSwitchingIconButton).last); // dark mode
        await tester.pumpAndSettle();
      });
    },
  );

  zGoldenTest(
    """When the button is clicked, it should change to the pressed icon,
    and then change to the rest icon after 3 seconds""",
    goldenFileName: "zup_switching_icon_button_pressed_icon_back_to_rest",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ZupSwitchingIconButton).first); // light mode
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ZupSwitchingIconButton).last); // dark mode
      await tester.pump(const Duration(seconds: 3));
    },
  );

  zGoldenTest(
    """When passing a custom pressed icon duration, the icon
    should not change if not passed that duration yet""",
    goldenFileName: "zup_switching_icon_button_custom_pressed_icon_duration_not_passed",
    (tester) async {
      await tester.runAsync(() async {
        const duration = Duration(seconds: 50);

        await tester.pumpDeviceBuilder(
          await goldenBuilder(
            pressedIconDuration: duration,
            pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
            restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ZupSwitchingIconButton).first); // light mode
        await tester.pumpAndSettle();
        await tester.tap(find.byType(ZupSwitchingIconButton).last); // dark mode
        await tester.pump(duration - const Duration(seconds: 1));
      });
    },
  );

  zGoldenTest(
    """When passing a custom pressed icon duration, the icon
    should change if the passed duration is passed""",
    goldenFileName: "zup_switching_icon_button_custom_pressed_icon_duration_passed",
    (tester) async {
      const duration = Duration(seconds: 50);

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          pressedIconDuration: duration,
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ZupSwitchingIconButton).first); // light mode
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ZupSwitchingIconButton).last); // dark mode
      await tester.pumpAndSettle(duration + const Duration(seconds: 10));
    },
  );

  zGoldenTest(
    """When hovering the button with the rest icon, it should show the rest icon tooltip
    message when setted""",
    goldenFileName: "zup_switching_icon_button_rest_icon_tooltip_message",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          snapshotThemeModes: false,
          restIconTooltipMessage: "Rest Icon Tooltip Message",
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );
      await tester.pumpAndSettle();

      await tester.hover(find.byType(ZupSwitchingIconButton).first);
      await tester.pumpAndSettle(const Duration(seconds: 10));
    },
  );

  zGoldenTest(
    """When hovering the button with the rest icon, but there's no tooltip message,
    it should not show the tooltip message""",
    goldenFileName: "zup_switching_icon_button_rest_icon_tooltip_message_not_setted",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          snapshotThemeModes: false,
          restIconTooltipMessage: null,
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ZupSwitchingIconButton).first);
      await tester.pumpAndSettle();

      await tester.hover(find.byType(ZupSwitchingIconButton).first);
      await tester.pumpAndSettle(const Duration(seconds: 10));
    },
  );

  zGoldenTest(
    """When hovering the button with the pressed icon, but there's no tooltip message,
    it should not show the tooltip message""",
    goldenFileName: "zup_switching_icon_button_pressed_icon_tooltip_message_not_setted",
    (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(
          await goldenBuilder(
            snapshotThemeModes: false,
            restIconTooltipMessage: null,
            pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
            restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ZupSwitchingIconButton).first);
        await tester.pumpAndSettle();

        await tester.hover(find.byType(ZupSwitchingIconButton).first);
      });
    },
  );

  zGoldenTest(
    """When hovering the button with the pressed icon, and the tooltip message is setted,
    it should show the tooltip message""",
    goldenFileName: "zup_switching_icon_button_pressed_icon_tooltip_message",
    (tester) async {
      await tester.runAsync(() async {
        await tester.pumpDeviceBuilder(
          await goldenBuilder(
            snapshotThemeModes: false,
            pressedIconTooltipMessage: "Pressed Icon Tooltip Message",
            pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
            restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(ZupSwitchingIconButton).first);
        await tester.pumpAndSettle();

        await tester.hover(find.byType(ZupSwitchingIconButton).first);
        await tester.pumpAndSettle();
      });
    },
  );

  zGoldenTest(
    "When setting the background color, it should be applied to the button",
    goldenFileName: "zup_switching_icon_button_background_color",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          backgroundColor: Colors.green,
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );

      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the button as not circle, the button should be a square",
    goldenFileName: "zup_switching_icon_button_not_circle",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          circle: false,
          backgroundColor: Colors.green,
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );

      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When setting the padding property,
  the padding of the butto should be the one passed""",
    goldenFileName: "zup_switching_icon_button_padding",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          padding: const EdgeInsets.all(100),
          backgroundColor: Colors.green,
          pressedIcon: const Icon(Icons.ac_unit, color: Colors.blueAccent),
          restIcon: const Icon(Icons.addchart_outlined, color: Colors.pink),
        ),
      );

      await tester.pumpAndSettle();
    },
  );

  zGoldenTest("When the button is pressed, it should callback", (tester) async {
    bool isPressed = false;

    await tester.pumpDeviceBuilder(
      await goldenBuilder(
        onPressed: (context) {
          isPressed = true;
        },
      ),
    );

    await tester.tap(find.byType(ZupSwitchingIconButton).first);
    await tester.pumpAndSettle(const Duration(seconds: 10));

    expect(isPressed, true);
  });
}
