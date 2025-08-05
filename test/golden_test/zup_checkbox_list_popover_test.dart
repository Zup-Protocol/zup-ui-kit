import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:zup_ui_kit/zup_checkbox_list_popover.dart';

import '../golden_config.dart';

void main() {
  Future<DeviceBuilder> goldenBuilder({
    List<ZupCheckboxItem>? items,
    Function(List<ZupCheckboxItem> items)? onValueChanged,
    String? searchHintText,
    Offset? positionAdjustment,
    ({String? description, String title})? searchNotFoundStateText,
    ({String clearAll, String selectAll})? allSelectionButtonText,
    bool snapshotDarkMode = false,
  }) async => await goldenDeviceBuilder(
    snapshotDarkMode: snapshotDarkMode,
    Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ZupCheckboxListPopover.show(
            context,
            allSelectionButtonText: allSelectionButtonText,
            positionAdjustment: positionAdjustment,
            searchNotFoundStateText: searchNotFoundStateText,
            searchHintText: searchHintText,
            items:
                items ??
                [
                  ZupCheckboxItem(title: 'Item 1', isChecked: true),
                  ZupCheckboxItem(title: 'Item 2', isChecked: true),
                  ZupCheckboxItem(title: 'Item 3', isChecked: true),
                ],
            onValueChanged: onValueChanged ?? (items) {},
          );
        });

        return const SizedBox.shrink();
      },
    ),
  );

  zGoldenTest(
    "When passing a list of checked items, they should start in checked state",
    goldenFileName: "zup_checkbox_list_popover_checked",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: [
            ZupCheckboxItem(title: 'Item 1', isChecked: true),
            ZupCheckboxItem(title: 'Item 2', isChecked: true),
            ZupCheckboxItem(title: 'Item 3', isChecked: true),
          ],
        ),
      );
    },
  );

  zGoldenTest(
    "When passing a list of unchecked items, they should start in unchecked state",
    goldenFileName: "zup_checkbox_list_popover_unchecked",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: [
            ZupCheckboxItem(title: 'Item 1', isChecked: false),
            ZupCheckboxItem(title: 'Item 2', isChecked: false),
            ZupCheckboxItem(title: 'Item 3', isChecked: false),
          ],
        ),
      );
    },
  );

  zGoldenTest(
    "When passing an icon, it should be displayed in the left side of the title",
    goldenFileName: "zup_checkbox_list_icon",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: [
            ZupCheckboxItem(title: 'Item 1', isChecked: false, icon: const Icon(Icons.close)),
            ZupCheckboxItem(title: 'Item 2', isChecked: false, icon: const Icon(Icons.lock_clock)),
            ZupCheckboxItem(title: 'Item 3', isChecked: false, icon: const Icon(Icons.add)),
          ],
        ),
      );
    },
  );

  zGoldenTest(
    """When starting the list with checked items and clicking on an item in the list,
    it should uncheck the item and callback the new items list""",
    goldenFileName: "zup_checkbox_list_popover_checked_click",
    (tester) async {
      final initialList = [
        ZupCheckboxItem(title: 'Item 0', isChecked: true),
        ZupCheckboxItem(title: 'Item 1', isChecked: true),
        ZupCheckboxItem(title: 'Item 2', isChecked: true),
      ];

      List<ZupCheckboxItem> newItems = [];
      const clickedItemIndex = 1;

      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: initialList, onValueChanged: (items) => newItems = items, snapshotDarkMode: false),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-$clickedItemIndex')).first);
      await tester.pumpAndSettle();

      expect(newItems, initialList..[clickedItemIndex].isChecked = false);
    },
  );

  zGoldenTest(
    """When starting the list with unchecked items and clicking on an item in the list,
    it should check the item and callback the new items list""",
    goldenFileName: "zup_checkbox_list_popover_unchecked_click",
    (tester) async {
      final initialList = [
        ZupCheckboxItem(title: 'Item 0', isChecked: false),
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false),
      ];

      List<ZupCheckboxItem> newItems = [];
      const clickedItemIndex = 1;

      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: initialList, onValueChanged: (items) => newItems = items, snapshotDarkMode: false),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-$clickedItemIndex')).first);
      await tester.pumpAndSettle();

      expect(newItems, initialList..[clickedItemIndex].isChecked = false);
    },
  );

  zGoldenTest(
    "When passing the search hint text, it should be displayed in the search bar",
    goldenFileName: "zup_checkbox_list_popover_search_hint_text",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(searchHintText: "Search hint text enabled"));
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When typing in the search bar,
  it should only show items in the list that match query""",
    goldenFileName: "zup_checkbox_list_popover_search",
    (tester) async {
      final items = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false),
        ZupCheckboxItem(title: 'Item 3', isChecked: false),
      ];

      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: items, searchHintText: "Search hint text enabled", snapshotDarkMode: false),
      );
      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "2");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When searching an item that is unchecked, and then click on it,
    it should check the item and callback the new items list""",
    goldenFileName: "zup_checkbox_list_popover_search_unchecked_click",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false),
        ZupCheckboxItem(title: 'Item 3', isChecked: false),
      ];

      List<ZupCheckboxItem> newItems = [];
      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: initialItems, onValueChanged: (items) => newItems = items, snapshotDarkMode: false),
      );

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "3");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-0')).first);
      await tester.pumpAndSettle();

      expect(newItems, initialItems..[2].isChecked = true);
    },
  );

  zGoldenTest(
    """When searching an item that is unchecked, checking it and then deleting
    the search, it should keep the item checked""",
    goldenFileName: "zup_checkbox_list_popover_search_unchecked_click_delete_search",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false),
        ZupCheckboxItem(title: 'Item 3', isChecked: false),
      ];

      await tester.pumpDeviceBuilder(await goldenBuilder(items: initialItems));

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "3");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-0')).first);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When searching an item that is checked, and then click on it,
    it should uncheck the item and callback the new items list""",
    goldenFileName: "zup_checkbox_list_popover_search_checked_click",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: true),
        ZupCheckboxItem(title: 'Item 2', isChecked: true),
        ZupCheckboxItem(title: 'Item 3', isChecked: true),
      ];

      List<ZupCheckboxItem> newItems = [];
      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: initialItems, onValueChanged: (items) => newItems = items),
      );

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "3");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-0')).first);
      await tester.pumpAndSettle();

      expect(newItems, initialItems..[2].isChecked = false);
    },
  );

  zGoldenTest(
    """When searching an item that is checked, unchecking it and then deleting
    the search, it should keep the item unchecked""",
    goldenFileName: "zup_checkbox_list_popover_search_checked_click_delete_search",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: true),
        ZupCheckboxItem(title: 'Item 2', isChecked: true),
        ZupCheckboxItem(title: 'Item 3', isChecked: true),
      ];

      await tester.pumpDeviceBuilder(await goldenBuilder(items: initialItems));

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "3");
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-0')).first);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When searching an item that does not exist, and the not found state is not set,
    it should show a blank list""",
    goldenFileName: "zup_checkbox_list_popover_search_not_found_blank_list",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder());

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "PINCHA NO EXISTE");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When searching an item that does not exist,
    and the not found state is set, it should the not found state""",
    goldenFileName: "zup_checkbox_list_popover_search_not_found_state",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(searchNotFoundStateText: (title: "ESO NO EXISTE", description: "NO EXISTE ESO")),
      );

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "PINCHA NO EXISTE");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the all selection button text, the button should be displayed",
    goldenFileName: "zup_checkbox_list_popover_all_selection_button_text",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(allSelectionButtonText: (clearAll: "Clear All", selectAll: "Select All")),
      );
    },
  );

  zGoldenTest(
    "When the items start checked, the all selection button action should be to uncheck them",
    goldenFileName: "zup_checkbox_list_popover_all_selection_button_clear",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: true),
        ZupCheckboxItem(title: 'Item 2', isChecked: true),
        ZupCheckboxItem(title: 'Item 3', isChecked: true),
      ];

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: initialItems,
          allSelectionButtonText: (clearAll: "Clear All", selectAll: "Select All"),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("zup-checkbox-list-popover-all-selection-button")).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When the items start unchecked, the all selection button action should be to check them",
    goldenFileName: "zup_checkbox_list_popover_all_selection_button_check",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false),
        ZupCheckboxItem(title: 'Item 3', isChecked: false),
      ];

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: initialItems,
          allSelectionButtonText: (clearAll: "Clear All", selectAll: "Select All"),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("zup-checkbox-list-popover-all-selection-button")).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When setting the positionAdjustment param, it should move the popover by that offset",
    goldenFileName: "zup_checkbox_list_popover_position_adjustment",
    (tester) async {
      await tester.pumpDeviceBuilder(await goldenBuilder(positionAdjustment: const Offset(-500, 100)));
    },
  );

  zGoldenTest(
    "When the all selection button is set, and the user is searching, the button should be hidden",
    goldenFileName: "zup_checkbox_list_popover_all_selection_button_search_hidden",
    (tester) async {
      await tester.pumpDeviceBuilder(
        await goldenBuilder(allSelectionButtonText: (clearAll: "Clear All", selectAll: "Select All")),
      );

      await tester.enterText(find.byKey(const Key("zup-checkbox-list-popover-search-field")), "3");
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    "When passing disabled items to the popover, they should not be selectable",
    goldenFileName: "zup_checkbox_list_popover_disabled_items_click",
    (tester) async {
      final items = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false, isDisabled: true),
        ZupCheckboxItem(title: 'Item 3', isChecked: false),
      ];

      await tester.pumpDeviceBuilder(await goldenBuilder(items: items));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("checkbox-item-1")).first);
      await tester.pumpAndSettle();
    },
  );

  zGoldenTest(
    """When passing disabled items to the popover, and then clicking the all selection button,
    they should not change its value """,
    goldenFileName: "zup_checkbox_list_popover_disabled_items_all_selection_button_click",
    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false),
        ZupCheckboxItem(title: 'Item 2', isChecked: false, isDisabled: true),
        ZupCheckboxItem(title: 'Item 3', isChecked: false, isDisabled: true),
      ];
      List<ZupCheckboxItem> newItems = [];

      await tester.pumpDeviceBuilder(
        await goldenBuilder(
          items: initialItems,
          onValueChanged: (items) => newItems = items,
          allSelectionButtonText: (clearAll: "Clear All", selectAll: "Select All"),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('zup-checkbox-list-popover-all-selection-button')).first);
      await tester.pumpAndSettle();

      expect(newItems, initialItems..[0].isChecked = true);
    },
  );

  zGoldenTest(
    """When passing items to the popover with an id, and then clicking to select or unselect them,
    it should callback with the new items but the id should be the same""",

    (tester) async {
      final initialItems = [
        ZupCheckboxItem(title: 'Item 1', isChecked: false, id: "item-1"),
        ZupCheckboxItem(title: 'Item 2', isChecked: false, id: "item-2"),
        ZupCheckboxItem(title: 'Item 3', isChecked: false, id: "item-3"),
      ];

      List<ZupCheckboxItem> newItems = [];

      await tester.pumpDeviceBuilder(
        await goldenBuilder(items: initialItems, onValueChanged: (items) => newItems = items, snapshotDarkMode: false),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('checkbox-item-0')).first);
      await tester.pumpAndSettle();

      expect(newItems.map((item) => item.id), initialItems.map((item) => item.id));
    },
  );
}
