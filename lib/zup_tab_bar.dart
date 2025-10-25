import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// Represents an item of the [ZupTabBar] tabs list
///
/// Used to define each tab's metadata and action on select
class ZupTabBarItem {
  /// Represents an item of the [ZupTabBar] tabs list
  ///
  /// Used to define each tab's metadata and action on select
  const ZupTabBarItem({required this.title, this.icon, required this.onSelected, this.key});

  /// A Key to be used in the tab widget.
  ///
  /// If null, none will be passed
  final Key? key;

  /// Title of the tab to be displayed
  final String title;

  /// Optionally display an icon next to the title (recommended for better readability)
  final Widget? icon;

  /// Action to be executed once the tab is selected
  final Function() onSelected;
}

/// A material design-like tab bar widget using the Zup design.
///
/// Useful for navigation between screens at same level
///
/// Use [ZupTabBarItem] to define each tab's metadata
class ZupTabBar extends StatefulWidget {
  /// A material design-like tab bar widget using the Zup design.
  ///
  /// Useful for navigation between screens at same level
  ///
  /// Use [ZupTabBarItem] to define each tab's metadata
  const ZupTabBar({super.key, required this.tabs, this.initialSelectedTabIndex = 0});

  /// List of [ZupTabBarItem] to define each tab's metadata and action on select. at least one item is required
  final List<ZupTabBarItem> tabs;

  /// Index of the initial selected tab
  ///
  /// By setting it, the [ZupTabBarItem] in the [tabs] list at this index will be selected once
  /// the [ZupTabBar] is initialized.
  ///
  /// Default to the first item in the [tabs] list
  final int initialSelectedTabIndex;

  @override
  State<ZupTabBar> createState() => _ZupTabBarState();
}

class _ZupTabBarState extends State<ZupTabBar> with SingleTickerProviderStateMixin {
  late final controller = TabController(
    initialIndex: widget.initialSelectedTabIndex,
    length: widget.tabs.length,
    vsync: this,
  );

  late int currentTabIndex = controller.index;
  int? hoveringTabIndex;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() => currentTabIndex = controller.index);
      widget.tabs[controller.index].onSelected();
    });
  }

  bool isItemSelectedOrHovering(ZupTabBarItem item) {
    return currentTabIndex == widget.tabs.indexOf(item) || hoveringTabIndex == widget.tabs.indexOf(item);
  }

  Color titleColor(ZupTabBarItem item) {
    return isItemSelectedOrHovering(item)
        ? Theme.of(context).primaryColor
        : context.brightness.isDark
        ? ZupColors.gray
        : ZupColors.gray2;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorColor: Theme.of(context).primaryColor,
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(width: 1.5, color: Theme.of(context).primaryColor)),
      ),
      labelPadding: const EdgeInsets.only(bottom: 5, right: 10),
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      padding: const EdgeInsets.all(0),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
      onHover: (value, index) {
        if (!value) return setState(() => hoveringTabIndex = null);
        setState(() => hoveringTabIndex = index);
      },
      tabs: widget.tabs
          .map(
            (item) => MouseRegion(
              key: item.key,
              cursor: SystemMouseCursors.click,
              child: MaterialButton(
                focusElevation: 0,
                highlightElevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                color: widget.tabs.indexOf(item) == hoveringTabIndex
                    ? ZupThemeColors.hoverOnBackground.themed(context.brightness)
                    : ZupThemeColors.background.themed(context.brightness),
                hoverColor: ZupThemeColors.hoverOnBackground.themed(context.brightness),
                splashColor: ZupThemeColors.splashOnBackground.themed(context.brightness),
                highlightColor: ZupThemeColors.splashOnBackground.themed(context.brightness),
                elevation: 0,
                hoverElevation: 0,
                onPressed: () => controller.animateTo(widget.tabs.indexOf(item)),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.icon != null) ...[
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(titleColor(item), BlendMode.srcIn),
                        child: item.icon!,
                      ),
                      const SizedBox(width: 12),
                    ],
                    Text(item.title, style: TextStyle(color: titleColor(item))),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
