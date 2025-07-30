import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupSelectableCard extends StatefulWidget {
  /// Show a selectable card from the Zup UI Kit.
  const ZupSelectableCard({
    super.key,
    required this.child,
    this.isSelected = false,
    this.padding = const EdgeInsets.all(20),
    this.onPressed,
    this.selectionAnimationDuration = const Duration(milliseconds: 200),
    this.boxShadow,
    this.onHoverChanged,
    this.width,
  });

  /// The child widget that will be displayed inside the card
  final Widget child;

  /// Whether the card should be in the selected state or not. Defaults to false
  final bool isSelected;

  /// The inside padding of the card, padding between the child and the card edges.
  /// Defaults to 20 in all directions
  final EdgeInsetsGeometry padding;

  /// The function that will be called when the card is pressed
  final Function()? onPressed;

  /// A callback that will be called when the card is hovered in or out
  /// with the value of the hovered state (true for hovered, false for not hovered)
  final Function(bool value)? onHoverChanged;

  /// The duration of the card selection animation, defaults to 200ms
  final Duration selectionAnimationDuration;

  /// Gives a fixed width to the card, defaults to null, so it will adapt to the content width
  final double? width;

  /// Add a custom shadow to the card. In case of null, the default shadow will be used.
  /// If you wish to remove the default shadow, you can pass an empty list
  final List<BoxShadow>? boxShadow;

  @override
  State<ZupSelectableCard> createState() => _ZupSelectableCardState();
}

class _ZupSelectableCardState extends State<ZupSelectableCard> {
  bool isHovering = false;

  final borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onPressed?.call(),
      onHover: (value) {
        setState(() => isHovering = value);
        widget.onHoverChanged?.call(value);
      },
      borderRadius: BorderRadius.circular(borderRadius),
      child: AnimatedContainer(
        padding: widget.padding,
        width: widget.width,
        duration: widget.selectionAnimationDuration,
        decoration: BoxDecoration(
          color: widget.isSelected ? ZupColors.brand7 : ZupColors.white,
          boxShadow:
              widget.boxShadow ??
              [
                BoxShadow(
                  color: (isHovering) ? ZupColors.brand6 : ZupColors.gray6,
                  blurRadius: 10,
                  offset: const Offset(5, 5),
                ),
              ],
          border: Border.all(
            strokeAlign: 1,
            width: (widget.isSelected || isHovering) ? 1.5 : 0.5,
            color: (widget.isSelected || isHovering)
                ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                : ZupColors.gray5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: widget.child,
      ),
    );
  }
}
