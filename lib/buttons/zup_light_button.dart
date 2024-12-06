import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupLightButton extends StatefulWidget {
  /// Build a button that change its child color when hovered. While it's not hovered the child is colored with a rest color
  const ZupLightButton({
    super.key,
    required this.child,
    this.restColor,
    this.hoverColor,
    required this.onPressed,
  });

  /// The child to be used in the button, can be a text, icon or any other widget
  final Widget child;

  /// The color to be used when the button is not hovered, note that it will be forced in the child. Defaults to [ZupColors.gray4]
  final Color? restColor;

  /// The color to be used when the button is hovered, note that it will be forced in the child. Defaults to [ZupColors.black]
  final Color? hoverColor;

  /// The function to be called when the button is pressed
  final Function() onPressed;

  @override
  State<ZupLightButton> createState() => _ZupLightButtonState();
}

class _ZupLightButtonState extends State<ZupLightButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isHovered ? (widget.hoverColor ?? ZupColors.black) : (widget.restColor ?? ZupColors.gray4),
            BlendMode.srcIn,
          ),
          child: IgnorePointer(child: widget.child),
        ),
      ),
    );
  }
}
