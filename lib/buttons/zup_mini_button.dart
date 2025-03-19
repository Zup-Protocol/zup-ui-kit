import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Show a button with a small size from the Zup UI Kit.
class ZupMiniButton extends StatefulWidget {
  const ZupMiniButton({super.key, this.icon, required this.title, this.iconSize = 16, this.onPressed});

  /// the left icon of the button, it will not be displayed if null
  final Widget? icon;

  /// the title of the button to be displayed
  final String title;

  /// the size of the passed [icon]. By default it is 16
  final double iconSize;

  /// the function to be called when the button is pressed
  final void Function()? onPressed;

  @override
  State<ZupMiniButton> createState() => _ZupMiniButtonState();
}

class _ZupMiniButtonState extends State<ZupMiniButton> with DeviceInfoMixin {
  bool isHovering = false;

  bool get isActive => widget.onPressed != null;

  Color get getTextColor {
    if (isActive) return isHovering ? Theme.of(context).primaryColor : ZupColors.black;

    return ZupColors.gray4;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => isHovering = true),
      onExit: (event) => setState(() => isHovering = false),
      child: MaterialButton(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: isMobileDevice ? 12 : 18),
        color: ZupColors.gray6,
        disabledColor: ZupColors.gray6,
        hoverColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        splashColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              SizedBox(
                width: widget.iconSize,
                height: widget.iconSize,
                child: Center(child: FittedBox(child: widget.icon)),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: getTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
