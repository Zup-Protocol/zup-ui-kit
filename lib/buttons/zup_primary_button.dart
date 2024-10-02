import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// Show a primary button from the Zup UI Kit.
class ZupPrimaryButton extends StatefulWidget {
  const ZupPrimaryButton({
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.border,
    this.isLoading = false,
    this.hoverElevation = 14,
    this.fixedIcon = false,
    this.fontWeight,
    required this.title,
    required this.onPressed,
    this.height = 50,
    this.padding = const EdgeInsets.all(20),
    this.mainAxisSize = MainAxisSize.min,
    this.alignCenter = false,
    this.width,
  });

  /// The background color of the button. If null, the color will be derived from the theme, using the primary color
  final Color? backgroundColor;

  /// The padding of the button. If null it will be 20 by default, for all sides
  final EdgeInsets padding;

  /// The foreground color of the button. If null, the default color will be white.
  final Color? foregroundColor;

  /// The icon to be displayed in the side of the button. If null, the icon will not be displayed
  final Widget? icon;

  /// The title to be displayed in the button
  final String title;

  /// The font weight of the title, defaults to w600 when active, and w400 when not active
  final FontWeight? fontWeight;

  /// A custom border to be used in the button. By default it does not have any border
  final BorderSide? border;

  /// The elevation of the button when hovered. By default it is 14
  final double hoverElevation;

  /// Whether the icon should be fixed in the button (show the icon always), or should be animated (show the icon only on hover). Defaults to false
  final bool fixedIcon;

  /// Whether the button is in loading state. Defaults to false. If true it will show a loading indicator
  final bool isLoading;

  /// The maximum height of the button. Defaults to 50
  final double height;

  /// Whether to make the button fill the whole available space or only the minimum space. Defaults to minimum
  final MainAxisSize mainAxisSize;

  /// The function to be called when the button is pressed. If null, the button will be in inactive state
  final Function()? onPressed;

  /// Whether the button text & icon should be in the center of the button. Defaults to false
  final bool alignCenter;

  /// The width of the button. If null, the button will be as tight as possible
  final double? width;

  @override
  State<ZupPrimaryButton> createState() => _ZupPrimaryButtonState();
}

class _ZupPrimaryButtonState extends State<ZupPrimaryButton> {
  final disabledForegroundColor = ZupColors.gray;

  late bool shouldExpand = false;

  bool get isLoadingOrExpanded => widget.isLoading || shouldExpand;

  Widget get buildIcon => ColorFiltered(
        colorFilter: ColorFilter.mode(
          widget.onPressed != null ? (widget.foregroundColor ?? Colors.white) : disabledForegroundColor,
          BlendMode.srcIn,
        ),
        child: widget.isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : widget.icon,
      );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (shouldExpand || widget.isLoading) return;

        setState(() => shouldExpand = true);
      },
      onExit: (_) {
        if (!shouldExpand || widget.isLoading) return;

        setState(() => shouldExpand = false);
      },
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: MaterialButton(
          disabledColor: ZupColors.gray5,
          disabledTextColor: disabledForegroundColor,
          color: widget.backgroundColor ?? Theme.of(context).primaryColor,
          animationDuration: const Duration(milliseconds: 800),
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: widget.border ?? BorderSide.none,
          ),
          onPressed: widget.onPressed,
          hoverElevation: widget.hoverElevation,
          elevation: 0,
          child: Row(
            mainAxisAlignment: widget.alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
            mainAxisSize: widget.mainAxisSize,
            children: [
              if (widget.icon != null && !widget.fixedIcon || widget.isLoading) ...[
                AnimatedPadding(
                  duration: Duration(milliseconds: isLoadingOrExpanded ? 0 : 400),
                  curve: Curves.decelerate,
                  padding: EdgeInsets.only(right: isLoadingOrExpanded ? 10 : 0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut,
                    width: isLoadingOrExpanded ? 20 : 0,
                    child: Center(child: buildIcon),
                  ),
                ),
              ],
              if (widget.icon != null && widget.fixedIcon && !widget.isLoading) ...[
                buildIcon,
                const SizedBox(width: 10),
              ],
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: widget.onPressed != null ? (widget.foregroundColor ?? Colors.white) : ZupColors.gray,
                  fontWeight: widget.onPressed != null ? (widget.fontWeight ?? FontWeight.w600) : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
