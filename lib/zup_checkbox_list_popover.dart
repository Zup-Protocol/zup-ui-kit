import 'package:flutter/material.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// Represents an item of the [ZupCheckboxListPopover]
class ZupCheckboxItem {
  /// Optional id to identify the item in the callback
  final String? id;

  /// The title that will be displayed for the item
  final String title;

  /// Whether the item is clickable to select/unselect. If true, the item will not be clickable
  final bool isDisabled;

  /// Optionally add an icon to the item in the left side of the title
  final Widget? icon;

  /// Whether the item should start as checked or unchecked
  bool isChecked;
  ZupCheckboxItem({
    required this.title,
    required this.isChecked,
    this.id,
    this.isDisabled = false,
    this.icon,
  });
}

/// The [ZupCheckboxListPopover] can mainly be used to filter a list of items, where the user will be able to enable or disable
/// by clicking on the items(or in the checkbox).
///
/// It can be used by simply calling the static method [ZupCheckboxListPopover.show] or you also can build your own show method
/// ann use the widget iself by calling its constructor [ZupCheckboxListPopover()].
class ZupCheckboxListPopover extends StatefulWidget {
  /// The [ZupCheckboxListPopover] can mainly be used to filter a list of items, where the user will be able to enable or disable
  /// by clicking on the items(or in the checkbox).
  ///
  /// It can be used by simply calling the static method [ZupCheckboxListPopover.show] or you also can build your own show method
  /// ann use the widget iself by calling its constructor [ZupCheckboxListPopover()].
  const ZupCheckboxListPopover({
    super.key,
    required this.items,
    required this.onValueChanged,
    this.searchHintText,
    this.searchNotFoundStateText,
    this.allSelectionButtonText,
  });

  /// The items that will be shown in the popover to be selected/unselected. It should be passed as a list of [ZupCheckboxItem]
  final List<ZupCheckboxItem> items;

  /// Callback that will be called when any of the items change its value to true or false
  final Function(List<ZupCheckboxItem> items) onValueChanged;

  /// Optionlly add a hint text to the search bar
  final String? searchHintText;

  /// Optionally enable the not found state when the user searches for something that
  /// does not exist in the list by passing the title of the state and a optional description
  /// for it
  final ({String title, String? description})? searchNotFoundStateText;

  /// Optionally enable a button to select/unselect all the items at once by just
  /// passing its title for each state.
  ///
  /// [selectAll] -> Title for the button that will select all the items
  /// [clearAll] -> Title for the button that will clear all the items (deselect)
  final ({String selectAll, String clearAll})? allSelectionButtonText;

  /// Show the checkbox popover based on a given context (e.g a button).
  ///
  /// [showBasedOnContext] -> the context that the popover should be displayed based on, usually the context of a button.
  ///
  /// [positionAdjustment] -> optionally adjust the position where the popover will be displayed.
  ///
  /// [items] -> the items that will be shown in the popover to be selected/unselected.
  ///
  /// [onValueChanged] -> callback that will be called when any of the items change its value to true or false
  ///
  /// [allSelectionButtonText] -> Optionally enable a button to select/unselect all the items at once by just
  /// passing its title for each state.
  ///
  /// [searchNotFoundStateText] -> Optionally enable the not found state when the user searches for something that
  /// does not exist in the list by passing the title of the state and a optional description
  /// for it
  ///
  /// [searchHintText] -> Optionally add a hint text to the search bar
  static void show(
    BuildContext showBasedOnContext, {
    Offset? positionAdjustment,
    ({String selectAll, String clearAll})? allSelectionButtonText,
    ({String title, String? description})? searchNotFoundStateText,
    String? searchHintText,
    required List<ZupCheckboxItem> items,
    required Function(List<ZupCheckboxItem> items) onValueChanged,
  }) =>
      ZupPopover.show(
        showBasedOnContext: showBasedOnContext,
        adjustment: positionAdjustment,
        child: ZupCheckboxListPopover(
          items: items,
          onValueChanged: onValueChanged,
          allSelectionButtonText: allSelectionButtonText,
          searchHintText: searchHintText,
          searchNotFoundStateText: searchNotFoundStateText,
        ),
      );

  @override
  State<ZupCheckboxListPopover> createState() => _ZupCheckboxListPopoverState();
}

class _ZupCheckboxListPopoverState extends State<ZupCheckboxListPopover> {
  late List<ZupCheckboxItem> itemsClone = List<ZupCheckboxItem>.from(widget.items);
  late List<ZupCheckboxItem> searchableList = List<ZupCheckboxItem>.from(itemsClone);

  void updateItemValue(bool value, ZupCheckboxItem item) {
    setState(() => itemsClone[itemsClone.indexOf(item)].isChecked = value);

    widget.onValueChanged(itemsClone);
  }

  void batchUpdateValue(bool value) {
    setState(() {
      for (final item in itemsClone) {
        if (!item.isDisabled) item.isChecked = value;
      }
    });

    widget.onValueChanged(itemsClone);
  }

  void updateSearch(String query) {
    setState(() {
      searchableList = itemsClone.where((item) => item.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  bool get isAllUnchecked => itemsClone.every((item) => !item.isChecked);
  bool get isSearching => searchableList.length != itemsClone.length;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 280,
      decoration: BoxDecoration(
        color: ZupColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ZupColors.gray5,
        ),
      ),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            titleSpacing: 10,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
            actionsPadding: const EdgeInsets.all(0),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ZupTextField(
                key: const Key("zup-checkbox-list-popover-search-field"),
                onChanged: (query) => updateSearch(query),
                hintText: widget.searchHintText,
              ),
            ),
          ),
          if (!isSearching && widget.allSelectionButtonText != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8).copyWith(bottom: 0),
                child: ZupMiniButton(
                  key: const Key('zup-checkbox-list-popover-all-selection-button'),
                  icon: isAllUnchecked
                      ? Assets.icons.checkmark.svg(package: "zup_ui_kit")
                      : Assets.icons.xmark.svg(package: "zup_ui_kit"),
                  iconSize: 10,
                  onPressed: () => batchUpdateValue(isAllUnchecked),
                  title: isAllUnchecked
                      ? widget.allSelectionButtonText!.selectAll
                      : widget.allSelectionButtonText!.clearAll,
                ),
              ),
            ),
          if ((isSearching && searchableList.isEmpty) && widget.searchNotFoundStateText != null) ...[
            SliverPadding(
                padding: const EdgeInsetsGeometry.all(10),
                sliver: SliverFillRemaining(
                  child: Center(
                    child: ZupInfoState(
                      iconSize: 18,
                      iconSpacing: 16,
                      icon: Assets.icons.xmark.svg(
                        package: "zup_ui_kit",
                        colorFilter: const ColorFilter.mode(ZupColors.red, BlendMode.srcIn),
                      ),
                      title: widget.searchNotFoundStateText!.title,
                      description: widget.searchNotFoundStateText?.description,
                    ),
                  ),
                )),
          ] else ...[
            SliverPadding(
              padding: const EdgeInsetsGeometry.only(top: 10, bottom: 10),
              sliver: SliverList.builder(
                itemCount: searchableList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.transparent,
                      child: CheckboxListTile(
                        key: Key("checkbox-item-$index"),
                        dense: true,
                        side: const BorderSide(width: 0, color: Colors.transparent),
                        contentPadding: const EdgeInsets.all(8),
                        checkboxShape: ContinuousRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          side: const BorderSide(width: 10),
                        ),
                        fillColor: WidgetStateProperty.resolveWith(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return Theme.of(context).primaryColor;
                            }

                            if (states.contains(WidgetState.disabled)) {
                              return ZupColors.gray6;
                            }

                            return ZupColors.gray5;
                          },
                        ),
                        checkboxScaleFactor: 1.1,
                        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                        enabled: !searchableList[index].isDisabled,
                        value: searchableList[index].isChecked,
                        checkColor: ZupColors.white,
                        onChanged: (value) => updateItemValue(value!, searchableList[index]),
                        title: Row(
                          children: [
                            if (searchableList[index].icon != null)
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 20, maxHeight: 20),
                                child: FittedBox(
                                  child: searchableList[index].icon!,
                                ),
                              ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                searchableList[index].title,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
