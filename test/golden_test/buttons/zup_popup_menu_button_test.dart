import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/buttons/zup_popup_menu_button.dart';

import '../../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    int initialSelectedIndex = 0,
    List<ZupPopupMenuItem>? items,
    double buttonHeight = 60.0,
    bool closeOnSelection = true,
    Function(int index)? onSelected,
  }) =>
      goldenDeviceBuilder(
        ZupPopupMenuButton(
          initialSelectedIndex: initialSelectedIndex,
          buttonHeight: buttonHeight,
          items: items ??
              [
                ZupPopupMenuItem(title: "Title"),
              ],
          onSelected: onSelected ?? (index) {},
          closeOnSelection: closeOnSelection,
        ),
      );

  zGoldenTest("Zup Popup Button Default", goldenFileName: "zup_popup_menu_button", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder());
  });

  zGoldenTest("When setting the height param, it should change the button height",
      goldenFileName: "zup_popup_menu_button_height_changed", (tester) async {
    return tester.pumpDeviceBuilder(await goldenBuilder(buttonHeight: 100));
  });

  zGoldenTest("When setting the initial selected index, it should show the item in the button",
      goldenFileName: "zup_popup_menu_button_initial_selected_index", (tester) async {
    const selectedItemTitle = "Title 2";

    await tester.pumpDeviceBuilder(await goldenBuilder(initialSelectedIndex: 1, items: [
      ZupPopupMenuItem(title: "Title 1"),
      ZupPopupMenuItem(title: selectedItemTitle),
    ]));

    expect(find.text(selectedItemTitle), findsOneWidget);
  });

  zGoldenTest(
      "When setting the initial selected index, and open the menu, it should show the item selected in the menu",
      goldenFileName: "zup_popup_menu_button_initial_selected_index_menu_open", (tester) async {
    const selectedItemTitle = "Title 2";

    await tester.pumpDeviceBuilder(await goldenBuilder(initialSelectedIndex: 1, items: [
      ZupPopupMenuItem(title: "Title 1"),
      ZupPopupMenuItem(title: selectedItemTitle),
    ]));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
  });

  zGoldenTest("When setting the items, and open the menu, it should show all the passed items",
      goldenFileName: "zup_popup_menu_button_menu_open", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(initialSelectedIndex: 0, items: [
      ZupPopupMenuItem(title: "Title 1"),
      ZupPopupMenuItem(title: "Title 2"),
      ZupPopupMenuItem(title: "Title 3"),
      ZupPopupMenuItem(title: "Title 4"),
      ZupPopupMenuItem(title: "Title 5"),
    ]));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
  });

  zGoldenTest(
      "When setting the items with icon, and open the menu, it should show all the passed items and their icons",
      goldenFileName: "zup_popup_menu_button_menu_open_with_icons", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(initialSelectedIndex: 0, items: [
      ZupPopupMenuItem(title: "Title 1", icon: const Icon(Icons.abc)),
      ZupPopupMenuItem(title: "Title 2", icon: const Icon(Icons.ac_unit)),
      ZupPopupMenuItem(title: "Title 3", icon: const Icon(Icons.one_x_mobiledata)),
      ZupPopupMenuItem(title: "Title 4", icon: const Icon(Icons.javascript)),
      ZupPopupMenuItem(title: "Title 5", icon: const Icon(Icons.apple)),
    ]));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
  });

  zGoldenTest("The onSelected callback should be called with the item index when selecting the item in the menu",
      (tester) async {
    const expectedSelectedItemIndex = 1;
    int? actualSelectedIndex;

    await tester.pumpDeviceBuilder(await goldenBuilder(
      initialSelectedIndex: 0,
      items: [
        ZupPopupMenuItem(title: "Title 1"),
        ZupPopupMenuItem(title: "Title 2"),
      ],
      onSelected: (index) => actualSelectedIndex = index,
    ));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("zup-popup-menu-item-$expectedSelectedItemIndex")));
    await tester.pumpAndSettle();

    expect(actualSelectedIndex, expectedSelectedItemIndex);
  });

  zGoldenTest("When selecting the item in the menu, it should change the button text",
      goldenFileName: "zup_popup_menu_button_selection", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      initialSelectedIndex: 0,
      items: [
        ZupPopupMenuItem(title: "Title 1"),
        ZupPopupMenuItem(title: "Title 2"),
      ],
    ));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("zup-popup-menu-item-1")));
    await tester.pumpAndSettle();
  });

  zGoldenTest(
      "When selecting the item in the menu, but the param `closeOnSelection` is false, it should not close the menu",
      goldenFileName: "zup_popup_menu_button_selection_not_close", (tester) async {
    await tester.pumpDeviceBuilder(await goldenBuilder(
      initialSelectedIndex: 0,
      closeOnSelection: false,
      items: [
        ZupPopupMenuItem(title: "Title 1"),
        ZupPopupMenuItem(title: "Title 2"),
      ],
    ));

    await tester.tap(find.byKey(const Key("zup-pop-up-menu-button")));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key("zup-popup-menu-item-1")));
    await tester.pumpAndSettle();
  });
}
