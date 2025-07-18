import 'package:flutter/material.dart';
import 'package:zup_ui_kit/src/pop_up_menu_item_wrapper.dart';

/// Show a popover from anywhere by calling the static method [ZupPopover.show]
class ZupPopover {
  /// Show a popover based in a given context (e.g below a button)
  ///
  /// @param `showBelowContext` -> the context that the popover should be displayed below, usually the context of a button
  /// @param `child` -> the content that the popover will show
  static Future<void> show({
    required BuildContext showBasedOnContext,
    required Widget child,
    Offset? adjustment,
    bool useRootNavigator = true,
  }) async {
    final renderBox = showBasedOnContext.findRenderObject() as RenderBox?;
    final offset = renderBox!.localToGlobal(adjustment ?? Offset.zero);

    final left = offset.dx;
    final top = offset.dy + renderBox.size.height;
    final right = left;

    await showMenu(
      context: showBasedOnContext,
      position: RelativeRect.fromLTRB(left, top, right, 0.0),
      menuPadding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      color: Colors.transparent,
      useRootNavigator: useRootNavigator,
      elevation: 0,
      items: [
        PopupMenuItemWrapper(
          value: null,
          child: child,
        ),
      ],
    );
  }
}
