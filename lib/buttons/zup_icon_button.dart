import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Show an icon button from the Zup UI Kit.
class ZupIconButton extends StatelessWidget {
  const ZupIconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.padding = const EdgeInsets.all(6),
    required this.onPressed,
    this.borderSide,
    this.minimumHeight,
    this.circle = false,
  });

  /// The main icon to show in the button.
  final Widget icon;

  /// The background color of the button. If null, the background color will be derived from the theme, using [ZupThemeColors.tertiaryButtonBackground] as default.
  final Color? backgroundColor;

  /// The border of the button. If null, the button will not have a border
  final BorderSide? borderSide;

  /// The icon color of the button. If null, the icon color will be derived from ZupColors, using [ZupColors.gray] as default.
  final Color? iconColor;

  /// The padding of the button, defaults to 6 on all sides.
  final EdgeInsetsGeometry? padding;

  /// The minimum height of the button. If null, the button will have no minimum height, it will be determined by the icon size.
  /// This is useful when you want to have a button with a fixed height, not depending on the icon size.
  final double? minimumHeight;

  /// Whether the button should be circular or not. If true, the button will be circular, if false, it will be rectangular with rounded corners.
  final bool circle;

  /// The callback that is called when the button is pressed. If null, the button will be in inactive state
  final void Function(BuildContext context)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        padding: padding,
        hoverColor: () {
          if (backgroundColor != null) {
            return context.brightness == Brightness.light
                ? backgroundColor?.darker(0.05)
                : backgroundColor?.lighter(0.05);
          }

          return ZupThemeColors.hoverOnTertiaryButton.themed(context.brightness);
        }(),
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(0, minimumHeight ?? 0)),
          shape: WidgetStatePropertyAll(
            circle
                ? CircleBorder(side: borderSide ?? BorderSide.none)
                : RoundedRectangleBorder(side: borderSide ?? BorderSide.none, borderRadius: BorderRadius.circular(12)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return ZupThemeColors.disabledButtonBackground.themed(context.brightness);
            }

            return backgroundColor ?? ZupThemeColors.tertiaryButtonBackground.themed(context.brightness);
          }),
        ),
        icon: ColorFiltered(colorFilter: ColorFilter.mode(iconColor ?? ZupColors.gray, BlendMode.srcIn), child: icon),
        onPressed: onPressed == null ? null : () => onPressed!(context),
      ),
    );
  }
}
