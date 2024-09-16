import 'package:flutter/material.dart';

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
    required this.title,
    required this.onPressed,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? icon;
  final String title;
  final BorderSide? border;
  final double hoverElevation;
  final bool fixedIcon;
  final bool isLoading;
  final Function()? onPressed;

  @override
  State<ZupPrimaryButton> createState() => _ZupPrimaryButtonState();
}

class _ZupPrimaryButtonState extends State<ZupPrimaryButton> {
  late bool shouldExpand = widget.isLoading;

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
      child: MaterialButton(
        color: widget.backgroundColor ?? const Color(0xFF7357FF),
        animationDuration: const Duration(milliseconds: 800),
        padding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: widget.border ?? BorderSide.none),
        height: 50,
        onPressed: widget.onPressed,
        hoverElevation: widget.hoverElevation,
        elevation: 0,
        child: Row(
          children: [
            if (widget.icon != null && !widget.fixedIcon || widget.isLoading) ...[
              AnimatedPadding(
                duration: Duration(milliseconds: shouldExpand ? 0 : 400),
                curve: Curves.decelerate,
                padding: EdgeInsets.only(right: shouldExpand ? 10 : 0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.fastEaseInToSlowEaseOut,
                  width: shouldExpand ? 20 : 0,
                  child: Center(
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(widget.foregroundColor ?? Colors.white, BlendMode.srcIn),
                      child: widget.isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : widget.icon,
                    ),
                  ),
                ),
              ),
            ],
            if (widget.icon != null && widget.fixedIcon && !widget.isLoading) ...[
              widget.icon!,
              const SizedBox(width: 10)
            ],
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: widget.foregroundColor ?? Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
