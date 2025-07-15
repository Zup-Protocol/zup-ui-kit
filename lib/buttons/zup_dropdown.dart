import 'package:flutter/material.dart';
import 'package:zup_ui_kit/src/pop_up_menu_item_wrapper.dart';

/// Show a dropdown from anywhere by calling the static method [ZupDropdown.show]
class ZupDropdown {
  /// Show a dropdown below a given context (e.g below a button)
  ///
  /// @param `showBelowContext` -> the context that the dropdown should be displayed below, usually the context of a button
  /// @param `child` -> the content that the dropdown will show
  static Future<void> show({
    required BuildContext showBelowContext,
    required Widget child,
    Offset? offset,
    bool useRootNavigator = true,
  }) async {
    final navigator = Navigator.of(showBelowContext, rootNavigator: useRootNavigator);
    final overlayBox = navigator.overlay?.context.findRenderObject() as RenderBox?;
    final targetBox = showBelowContext.findRenderObject() as RenderBox?;

    if (targetBox == null || overlayBox == null || !targetBox.attached || !overlayBox.attached) return;

    final position = RelativeRect.fromRect(
      targetBox.localToGlobal(
            Offset(0, targetBox.size.height) + (offset ?? Offset.zero),
            ancestor: overlayBox,
          ) &
          targetBox.size,
      Offset.zero & overlayBox.size,
    );

    await showMenu(
      context: navigator.context,
      position: position,
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
