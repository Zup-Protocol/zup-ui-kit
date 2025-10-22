import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Show a button that does not have a background color set, only borders
class ZupOutlinedButton extends StatelessWidget {
  /// Show a button that does not have a background color set, only borders
  const ZupOutlinedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.trailingIcon,
    this.leadingIcon,
    this.leadingIconSpacing = 10,
    this.trailingIconSpacing = 10,
  });

  /// The spacing between the leading icon and the title (left side)
  ///
  /// Defaults to 10
  final double leadingIconSpacing;

  /// The spacing between the title and the trailing icon (right side)
  ///
  /// Defaults to 10
  final double trailingIconSpacing;

  /// Optionally add an icon to the right of the title
  final Widget? trailingIcon;

  /// Optionally add an icon to the left of the title
  final Widget? leadingIcon;

  /// The title that will be displayed as the main text of the button
  final Text title;

  /// The function to be called once the button is pressed
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: onPressed == null
            ? BorderSide.none
            : BorderSide(
                color: ZupThemeColors.borderOnBackground.themed(context.brightness),
                width: context.brightness.isDark ? 1 : 0.5,
              ),
      ),
      child: InkWell(
        onTap: onPressed,
        splashColor: ZupThemeColors.splashOnBackground.themed(context.brightness),
        hoverColor: ZupThemeColors.hoverOnBackground.themed(context.brightness),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[leadingIcon!, SizedBox(width: leadingIconSpacing)],
              DefaultTextStyle.merge(
                style: TextStyle(
                  fontWeight: title.style?.fontWeight ?? FontWeight.w600,
                  fontSize: title.style?.fontSize ?? 17,
                  color:
                      title.style?.color ??
                      (onPressed == null
                          ? ZupThemeColors.disabledText.themed(context.brightness)
                          : Theme.of(context).primaryColor),
                ),
                child: title,
              ),

              if (trailingIcon != null) ...[SizedBox(width: trailingIconSpacing), trailingIcon!],
            ],
          ),
        ),
      ),
    );
  }
}
