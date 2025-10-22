import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Display a tag that has a title for a given value and an optional icon
///
/// Useful for displaying attributes of something, like a fee for example,
/// or version of something
class ZupTitledValueTag extends StatelessWidget {
  const ZupTitledValueTag({super.key, required this.value, required this.title, this.trailingIcon});

  /// The title of the value to be displayed, e.g. "Fee"
  final String title;

  /// The value to be displayed, e.g. "0.01"
  final String value;

  /// An optional icon to be displayed on the right side of the tag, after the value
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.brightness.isDark ? ZupColors.black3 : ZupColors.gray6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: ZupColors.gray),
          ),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
          if (trailingIcon != null) ...[const SizedBox(width: 8), trailingIcon!],
        ],
      ),
    );
  }
}
