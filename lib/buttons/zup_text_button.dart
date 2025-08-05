import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Show a text button from the Zup UI Kit.
class ZupTextButton extends StatefulWidget {
  const ZupTextButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.applyColorsToIcon = true,
    this.alignLeft = true,
  });

  /// The callback that is called when the button is tapped
  final Function()? onPressed;

  /// an optional icon to be displayed in the left side of the button
  final Widget? icon;

  /// The text to be displayed on the button
  final String label;

  /// Choose wether to have the icon with the same color as the text or no. Defaults to true
  final bool applyColorsToIcon;

  /// Choose wether to move the button to the left the same amount as the left padding. Defaults to true
  ///
  /// Useful when you want to align the button to the left with other texts, to not make it look misaligned.
  final bool alignLeft;

  @override
  State<ZupTextButton> createState() => _ZupTextButtonState();
}

class _ZupTextButtonState extends State<ZupTextButton> {
  bool isHovering = false;

  final horizontalPadding = 12.0;

  Color get foregroundColor {
    if (widget.onPressed == null) return ZupColors.gray4;

    return isHovering ? Theme.of(context).primaryColor.withValues(alpha: 0.7) : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(widget.alignLeft ? -(horizontalPadding) : 0, 0),
      child: TextButton.icon(
        onHover: (value) => setState(() => isHovering = value),
        onPressed: widget.onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: InkRipple.splashFactory,
          foregroundColor: WidgetStateProperty.all(foregroundColor),
          iconColor: WidgetStateProperty.all(foregroundColor),
          surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: horizontalPadding)),
        ),
        icon: widget.icon == null
            ? null
            : AnimatedScale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutBack,
                scale: isHovering ? 1.2 : 1,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    foregroundColor,
                    widget.applyColorsToIcon ? BlendMode.srcIn : BlendMode.dst,
                  ),
                  child: widget.icon,
                ),
              ),
        label: Text(
          widget.label,
          style: TextStyle(color: foregroundColor, fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
