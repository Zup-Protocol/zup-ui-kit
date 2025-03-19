import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Show a text field from the Zup UI Kit.
class ZupTextField extends StatelessWidget {
  const ZupTextField({super.key, this.hintText, this.onChanged});

  /// the hint text that will be displayed in the text field, when it is empty
  final String? hintText;

  /// Called immediately when a value is typed in the textfield
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      prefixIcon: const Icon(Icons.search),
      suffixIcon: const Icon(Icons.close),
      onChanged: onChanged,
      backgroundColor: ZupColors.gray6,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      suffixInsets: const EdgeInsets.all(10),
      prefixInsets: const EdgeInsets.all(10),
      placeholder: hintText ?? "",
      style: const TextStyle(color: ZupColors.black, fontSize: 16),
      placeholderStyle: const TextStyle(color: ZupColors.gray4, fontSize: 16),
      itemColor: ZupColors.gray,
    );
  }
}
