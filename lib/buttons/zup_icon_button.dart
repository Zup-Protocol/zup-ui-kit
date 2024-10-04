import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

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
  });

  /// The main icon to show in the button.
  final Widget icon;

  /// The background color of the button. If null, the background color will be derived from ZupColors, using [ZupColors.tertiary] as default.
  final Color? backgroundColor;

  /// The border of the button. If null, the button will not have a border
  final BorderSide? borderSide;

  /// The icon color of the button. If null, the icon color will be derived from ZupColors, using [ZupColors.gray] as default.
  final Color? iconColor;

  /// The padding of the button, defaults to 6 on all sides.
  final EdgeInsetsGeometry? padding;

  /// The callback that is called when the button is pressed. If null, the button will be in inactive state
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        padding: padding,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          shape: WidgetStatePropertyAll(CircleBorder(side: borderSide ?? BorderSide.none)),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return ZupColors.gray5;
              }
              return backgroundColor ?? ZupColors.tertiary;
            },
          ),
        ),
        icon: ColorFiltered(
          colorFilter: ColorFilter.mode(
            iconColor ?? ZupColors.gray,
            BlendMode.srcIn,
          ),
          child: icon,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
