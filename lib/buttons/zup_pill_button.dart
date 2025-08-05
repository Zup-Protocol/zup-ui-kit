import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';

class ZupPillButton extends StatefulWidget {
  /// Show a button with the style of a pill from the Zup UI Kit.
  ZupPillButton({
    super.key,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.title,
  }) {
    assert(icon != null || title != null, 'Either icon or title must be provided');
  }

  /// The background color of the button, where the text will be placed at.
  /// Defaults to the primary color defined in the theme (lightered or darkened based on the theme mode)
  final Color? backgroundColor;

  /// The color of the text, and of the icon background in the button (If an icon is provided). Defaults to primary color
  /// Defined in the theme
  ///
  /// Note that if there's no text in the button, the passed background color will be applied to the icon background instead
  /// of using the passed foreground color, and the foreground color will be applied to the icon itself
  final Color? foregroundColor;

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
  late Color backgroundColor = widget.backgroundColor ?? Theme.of(context).primaryColor.lighter(0.6);
  late Color foregroundColor = widget.foregroundColor ?? Theme.of(context).primaryColor;

  TextStyle get titleStyle => TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: foregroundColor);

  double get titleWidth {
    if (widget.title == null) return 0;

    final textSpan = TextSpan(text: widget.title);
    final tp = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    );
    tp.layout();

    return tp.size.width;
  }

  @override
  void didUpdateWidget(covariant ZupPillButton oldWidget) {
    if (widget.backgroundColor != null) backgroundColor = widget.backgroundColor!;
    if (widget.foregroundColor != null) foregroundColor = widget.foregroundColor!;

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => widget.onPressed(context),
      color: backgroundColor,
      hoverElevation: 0,
      hoverColor: backgroundColor.computeLuminance() > 0.5
          ? backgroundColor.darker(0.02)
          : backgroundColor.lighter(0.02),
      elevation: 0,
      splashColor: backgroundColor.withValues(alpha: 0.1),
      padding: EdgeInsets.all(
        isMobileDevice ? 6 : 12,
      ).copyWith(right: widget.title == null ? (isMobileDevice ? 6 : 12) : 0),
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
                color: widget.title != null ? foregroundColor : backgroundColor.withValues(alpha: 0.01),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(foregroundColor, widget.title != null ? BlendMode.dst : BlendMode.srcIn),
                child: widget.icon,
              ),
            ),
          ],
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.decelerate,
            width: widget.title != null ? (titleWidth + 30) : 0,
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
                    Text(widget.title!, style: titleStyle),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
