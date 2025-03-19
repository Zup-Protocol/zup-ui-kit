import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupPillButton extends StatefulWidget {
  /// Show a button with the style of a pill from the Zup UI Kit.
  ZupPillButton({
    super.key,
    this.icon,
    this.backgroundColor = ZupColors.brand7,
    this.foregroundColor = ZupColors.brand,
    required this.onPressed,
    this.title,
  }) {
    assert(icon != null || title != null, 'Either icon or title must be provided');
  }

  /// The background color of the button, where the text will be placed at. Defaults to [ZupColors.brand7]
  final Color backgroundColor;

  /// The color of the text, and of the icon background in the button (If an icon is provided). Defaults to [ZupColors.brand]
  ///
  /// Note that if there's no text in the button, the passed background color will be applied to the icon background instead
  /// of using the passed foreground color, and the foreground color will be applied to the icon itself
  final Color foregroundColor;

  /// An optional icon to de displayed at the left side of the button, besides the title
  final Widget? icon;

  /// An optional title to be displayed at the center of the button
  final String? title;

  /// The callback to be called once the button is pressed
  final void Function(BuildContext buttonContext) onPressed;

  @override
  State<ZupPillButton> createState() => _ZupPillButtonState();
}

class _ZupPillButtonState extends State<ZupPillButton> with DeviceInfoMixin {
  late bool shouldShowText = false || widget.title != null;

  TextStyle get titleStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: widget.foregroundColor,
      );

  double get titleWidth {
    if (widget.title == null) return 0;

    final textSpan = TextSpan(text: widget.title);
    final tp =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr, textScaler: MediaQuery.textScalerOf(context));
    tp.layout();

    return tp.size.width;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => widget.onPressed(context),
      color: widget.backgroundColor,
      hoverElevation: 0,
      elevation: 0,
      padding: EdgeInsets.all(isMobileDevice ? 6 : 12).copyWith(
        right: widget.title == null ? (isMobileDevice ? 6 : 12) : 0,
      ),
      minWidth: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              padding: EdgeInsets.all(isMobileDevice ? 4 : 6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.title != null ? widget.foregroundColor : widget.backgroundColor.withValues(alpha: 0.01),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  widget.foregroundColor,
                  widget.title != null ? BlendMode.dst : BlendMode.srcIn,
                ),
                child: widget.icon,
              ),
            ),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.decelerate,
            width: widget.title != null ? (titleWidth + 24) : 0,
            onEnd: () => setState(() {
              if (widget.title == null) {
                shouldShowText = false;
                return;
              }

              shouldShowText = true;
            }),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: shouldShowText ? 1 : 0,
              child: Row(
                children: [
                  if (widget.title != null && shouldShowText) ...[
                    const SizedBox(width: 10),
                    Text(
                      widget.title!,
                      style: titleStyle,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
