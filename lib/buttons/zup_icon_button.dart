import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupIconButton extends StatelessWidget {
  const ZupIconButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.padding = const EdgeInsets.all(6),
    required this.onPressed,
  });

  final Widget icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: IconButton(
        padding: padding,
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size.zero),
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? ZupColors.tertiary,
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
