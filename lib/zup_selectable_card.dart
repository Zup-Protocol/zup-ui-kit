import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

class ZupSelectableCard extends StatefulWidget {
  /// Show a selectable card from the Zup UI Kit.
  const ZupSelectableCard({
    super.key,
    required this.child,
    this.isSelected = false,
    this.padding = const EdgeInsets.all(20),
    this.onPressed,
    this.selectionAnimationDuration = const Duration(milliseconds: 200),
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

  @override
  State<ZupSelectableCard> createState() => _ZupSelectableCardState();
}

class _ZupSelectableCardState extends State<ZupSelectableCard> {
  bool isHovering = false;

  final borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: widget.isSelected
          ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
          : ZupThemeColors.backgroundSurface.themed(context.brightness),
      child: InkWell(
        onTap: () => widget.onPressed?.call(),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onHover: (value) {
          setState(() => isHovering = value);
          widget.onHoverChanged?.call(value);
        },
        child: AnimatedContainer(
          padding: widget.padding,
          width: widget.width,
          duration: widget.selectionAnimationDuration,
          decoration: BoxDecoration(
            border: Border.all(
              strokeAlign: 1,
              width: (widget.isSelected || isHovering) ? 1.5 : 0.5,
              color: (widget.isSelected || isHovering)
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                  : ZupThemeColors.borderOnBackground.themed(context.brightness),
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
