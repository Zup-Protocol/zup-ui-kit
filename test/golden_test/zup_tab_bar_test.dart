import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/zup_tab_bar.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    int initialSelectedTabIndex = 0,
    bool snapshotThemeModes = true,
    bool isDarkMode = false,
    List<ZupTabBarItem>? tabs,
  }) async => await goldenDeviceBuilder(
    snapshotThemeModes: snapshotThemeModes,
    isDarkMode: isDarkMode,
    ZupTabBar(
      initialSelectedTabIndex: initialSelectedTabIndex,
      tabs:
          tabs ?? [ZupTabBarItem(title: "Tab 1", onSelected: () {}), ZupTabBarItem(title: "Tab 2", onSelected: () {})],
    ),
  );

  zGoldenTest(
    "When passing a initial selected tab index, it should initalize the widget with the selected tab at that index",
    goldenFileName: "zup_tab_bar_initial_selected_tab_index",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(initialSelectedTabIndex: 1));
    },
  );

  zGoldenTest(
    "When hovering a tab in light mode, it should show the hover state",
    goldenFileName: "zup_tab_bar_hover_light_mode",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(snapshotThemeModes: false));
      await tester.hover(find.text("Tab 2"));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When hovering a tab in dark mode, it should show the hover state",
    goldenFileName: "zup_tab_bar_hover_dark_mode",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(snapshotThemeModes: false, isDarkMode: true));
      await tester.hover(find.text("Tab 2"));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When adding an icon to the tab bar, it should be applied as a leading icon",
    goldenFileName: "zup_tab_bar_with_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          tabs: [
            ZupTabBarItem(title: "Tab 1", icon: const Icon(Icons.add), onSelected: () {}),
            ZupTabBarItem(title: "Tab 2", onSelected: () {}, icon: const Icon(Icons.access_alarm)),
          ],
        ),
      );
    },
  );

  zGoldenTest(
    "When pressing the a tab, it should switch to the tab, and call the onSelected callback of the tab",
    goldenFileName: "zup_tab_bar_switch_tab",
    (tester) async {
      bool callbackCalled = false;

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          tabs: [
            ZupTabBarItem(title: "Tab 1", icon: const Icon(Icons.add), onSelected: () {}),
            ZupTabBarItem(
              title: "Tab 2",
              onSelected: () {
                callbackCalled = true;
              },
              icon: const Icon(Icons.access_alarm),
            ),
          ],
        ),
      );

      await tester.tap(find.text("Tab 2").first); // light mode
      await tester.pumpAndSettle();

      await tester.tap(find.text("Tab 2").last); // dark mode
      await tester.pumpAndSettle();

      expect(callbackCalled, true);
    },
  );
}
