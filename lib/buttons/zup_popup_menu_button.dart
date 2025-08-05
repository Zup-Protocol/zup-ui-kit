import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zup_core/extensions/extensions.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';
import 'package:zup_ui_kit/src/pop_up_menu_item_wrapper.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Item for the [ZupPopupMenuButton]. This item will be shown in the dropdown list.
class ZupPopupMenuItem {
  ZupPopupMenuItem({required this.title, this.icon});

  /// The title of the item
  final String title;

  /// Optional icon to show next to the title
  final Widget? icon;
}

/// Display a button that opens a popup with a list of items on it.
class ZupPopupMenuButton extends StatefulWidget {
  ZupPopupMenuButton({
    super.key,
    required this.initialSelectedIndex,
    required this.items,
    required this.onSelected,
    this.closeOnSelection = true,
    this.buttonHeight = 50,
    this.compact = false,
  }) {
    if (compact) {
      assert(
        items.map((item) => item.icon).every((icon) => icon != null),
        "All items must have an icon when the button is compact",
      );
    }
  }

  /// The initial selected item index, the one that will be visible in the button
  final int initialSelectedIndex;

  /// The list of items to show in the menu, when clicking the button
  final List<ZupPopupMenuItem> items;

  /// Callback which is called when any item is selected
  final Function(int selectedIndex) onSelected;

  /// Whether to close the menu when an item is selected or to keep it open
  final bool closeOnSelection;

  /// The height of the button to show the menu
  final double buttonHeight;

  /// Whether the button to show the popup should be compact or not.
  ///
  /// A compact button will only show the icon of the selected item, while the normal
  /// button will show the icon + title.
  ///
  /// Note that an icon is necessary for the compact button, so every item must have one,
  /// if the button is compact.
  final bool compact;

  @override
  State<ZupPopupMenuButton> createState() => _ZupPopupMenuButtonState();
}

class _ZupPopupMenuButtonState extends State<ZupPopupMenuButton> {
  late int _selectedIndex = widget.initialSelectedIndex;
  final StreamController<int> _selectedItemIndexStreamController = StreamController<int>.broadcast();
  late final Stream<int> _selectedItemIndexStream = _selectedItemIndexStreamController.stream;

  void _showMenu() {
    final renderBox = context.findRenderObject() as RenderBox?;
    final offset = renderBox!.localToGlobal(const Offset(0, 10));

    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    final right = left;

    showMenu(
      context: context,
      useRootNavigator: true,
      position: RelativeRect.fromLTRB(left, top, right, 0.0),
      color: ZupThemeColors.backgroundSurface.themed(context.brightness),
      menuPadding: const EdgeInsets.all(11),
      elevation: 0,
      surfaceTintColor: ZupColors.white,
      semanticLabel: "ZupPopupMenuButton",
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ZupThemeColors.borderOnBackground.themed(context.brightness), width: 1),
      ),
      items: List.generate(
        widget.items.length,
        (index) => PopupMenuItemWrapper(
          key: Key("zup-popup-menu-item-$index"),
          value: index,
          child: StreamBuilder(
            stream: _selectedItemIndexStream,
            initialData: _selectedIndex,
            builder: (context, snapshot) {
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => _updateSelectedIndex(index),
                hoverColor: ZupThemeColors.hoverOnBackgroundSurface.themed(context.brightness),
                splashColor: ZupThemeColors.splashOnBackgroundSurface.themed(context.brightness),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:
                      Row(
                        children: [
                          if (widget.items[index].icon != null)
                            Badge(
                              label: Assets.icons.checkmarkCircleFill.svg(
                                package: "zup_ui_kit",
                                colorFilter: ColorFilter.mode(Theme.of(context).primaryColor, BlendMode.srcIn),
                              ),
                              alignment: Alignment.bottomRight,
                              backgroundColor: Colors.transparent,
                              isLabelVisible: snapshot.data == index,
                              offset: const Offset(0, -15),
                              child: Container(
                                height: 30,
                                width: 30,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: ZupThemeColors.borderOnBackgroundSurface.themed(context.brightness),
                                  ),
                                ),
                                child: widget.items[index].icon!,
                              ),
                            ),
                          const SizedBox(width: 10),
                          Text(
                            widget.items[index].title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: snapshot.data == index ? FontWeight.w600 : FontWeight.w500,
                              color: snapshot.data == index
                                  ? Theme.of(context).primaryColor
                                  : ZupThemeColors.primaryText.themed(context.brightness),
                            ),
                          ),
                        ],
                      ).animate(
                        effects: [
                          SlideEffect(
                            delay: Duration(milliseconds: 100 * (index ~/ 2)),
                            duration: const Duration(milliseconds: 300),
                            begin: const Offset(0, -5),
                            end: Offset.zero,
                            curve: Curves.easeOutBack,
                          ),
                        ],
                      ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _updateSelectedIndex(int index) {
    _selectedIndex = index;
    _selectedItemIndexStreamController.add(index);
    widget.onSelected(index);

    if (widget.closeOnSelection) Navigator.pop(context);
  }

  @override
  void dispose() {
    _selectedItemIndexStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _selectedItemIndexStream,
      initialData: _selectedIndex,
      builder: (context, snapshot) {
        return SizedBox(
          height: widget.buttonHeight,
          child: MaterialButton(
            minWidth: widget.compact ? 0 : null,
            splashColor: ZupThemeColors.splashOnBackgroundSurface.themed(context.brightness),
            key: const Key("zup-pop-up-menu-button"),
            color: ZupThemeColors.backgroundSurface.themed(context.brightness),
            hoverColor: ZupThemeColors.hoverOnBackgroundSurface.themed(context.brightness),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: ZupThemeColors.borderOnBackground.themed(context.brightness)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(right: 25),
            elevation: 0,
            hoverElevation: 0,
            onPressed: () => _showMenu(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.items[snapshot.data!].icon != null)
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FittedBox(fit: BoxFit.contain, child: widget.items[snapshot.data!].icon),
                  ),
                const SizedBox(width: 5),
                if (!widget.compact) ...[
                  Text(
                    widget.items[snapshot.data!].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ZupThemeColors.primaryText.themed(context.brightness),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Assets.icons.chevronUpChevronDown.svg(
                  package: "zup_ui_kit",
                  height: 12,
                  colorFilter: const ColorFilter.mode(ZupColors.gray, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
