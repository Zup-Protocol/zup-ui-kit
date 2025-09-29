import 'package:flutter/material.dart';

/// Display a non-interactive widget that represents a tag with a title and an optional icon
///
/// Useful for displaying a status for example
class ZupTag extends StatelessWidget {
  const ZupTag({
    super.key,
    required this.title,
    required this.color,
    this.icon,
    this.iconSize = 16,
    this.applyColorToIcon = true,
    this.iconSpacing = 8,
    this.maxHeight = 28,
    this.padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
    this.borderColor,
  });

  /// The text to be displayed inside the tag
  final String title;

  /// The main color of the tag
  final Color color;

  /// The icon to be displayed next to the title
  final Widget? icon;

  /// Whether to apply the color passed in [color] to the icon, defaults to true
  final bool applyColorToIcon;

  /// The size of the icon, defaults to 16. Note that the icon size will not change the tag height,
  /// if the icon size is too big, it will likely throw an overflow error
  final double iconSize;

  /// The horizontal spacing between the icon and the title, defaults to 8
  final double iconSpacing;

  /// The maximum height of the tag, defaults to 28
  final double maxHeight;

  /// The padding of the tag, defaults to 2 vertical and 10 horizontal
  final EdgeInsetsGeometry? padding;

  /// Optional border color, if null, the tag will use the same as [color]
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? color),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            ColorFiltered(
              colorFilter: ColorFilter.mode(color, applyColorToIcon ? BlendMode.srcIn : BlendMode.dst),
              child: SizedBox(height: iconSize, width: iconSize, child: icon!),
            ),
          SizedBox(width: icon != null ? iconSpacing : 0),
          Text(
            title,
            style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
