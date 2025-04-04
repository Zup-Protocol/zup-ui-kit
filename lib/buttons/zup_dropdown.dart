import 'package:flutter/material.dart';
import 'package:zup_core/extensions/build_context_extension.dart';
import 'package:zup_ui_kit/src/pop_up_menu_item_wrapper.dart';

/// Show a dropdown from anywhere by calling the static method [ZupDropdown.show]
class ZupDropdown {
  /// Show a dropdown below a given context (e.g below a button)
  ///
  /// @param `showBelowContext` -> the context that the dropdown should be displayed below, usually the context of a button
  /// @param `child` -> the content that the dropdown will show
  static Future<void> show({required BuildContext showBelowContext, required Widget child, Offset? offset}) {
    return showMenu(
      context: showBelowContext,
      position: showBelowContext.relativeRect(
        adjustOffsetBy: offset ?? const Offset(0, 5),
        relativePosition: RelativePosition.below,
      ),
      menuPadding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      color: Colors.transparent,
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
