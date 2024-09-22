import 'package:flutter/material.dart';

class PopupMenuItemWrapper extends PopupMenuItem {
  const PopupMenuItemWrapper({super.key, required super.child, required super.value});

  @override
  PopupMenuItemState<dynamic, PopupMenuItem> createState() => _PopupMenuItemState();
}

class _PopupMenuItemState<T> extends PopupMenuItemState {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
