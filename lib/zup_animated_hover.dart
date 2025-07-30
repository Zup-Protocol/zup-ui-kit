import 'package:flutter/material.dart';

enum ZupAnimatedHoverType {
  /// Scale down or up the widget on hover. 1 as value is the child size, 1.2 is 20% bigger and 0.8 is 20% smaller
  scale,

  /// Change the opacity of the widget on hover. 1 as value is fully visible and 0 is fully transparent
  opacity;

  double _getDefaultAnimationValue() {
    switch (this) {
      case ZupAnimatedHoverType.scale:
        return 1.2;
      case ZupAnimatedHoverType.opacity:
        return 0.7;
    }
  }
}

/// Animate any widget on hover with by the passed [animationValue] in the passed [type]
class ZupAnimatedHover extends StatefulWidget {
  /// Animate any widget on hover with by the passed [animationValue] in the passed [type]
  const ZupAnimatedHover({super.key, required this.child, this.animationValue, this.type = ZupAnimatedHoverType.scale});

  /// The widget to animate on hover
  final Widget child;

  /// The value to animate on hover, based on the [type] used. E.g 0.7 for opacity and 1.2 for scale
  final double? animationValue;

  /// The type of animation to use for the [child] once hovered
  final ZupAnimatedHoverType type;

  @override
  State<ZupAnimatedHover> createState() => _ZupAnimatedHoverState();
}

class _ZupAnimatedHoverState extends State<ZupAnimatedHover> {
  final animationDuration = const Duration(milliseconds: 200);
  bool isHovering = false;

  Widget get animatedChild {
    switch (widget.type) {
      case ZupAnimatedHoverType.scale:
        return AnimatedScale(
          scale: isHovering ? (widget.animationValue ?? widget.type._getDefaultAnimationValue()) : 1,
          duration: animationDuration,
          curve: Curves.decelerate,
          child: widget.child,
        );

      case ZupAnimatedHoverType.opacity:
        return AnimatedOpacity(
          opacity: isHovering ? (widget.animationValue ?? widget.type._getDefaultAnimationValue()) : 1,
          curve: Curves.decelerate,
          duration: animationDuration,
          child: widget.child,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: animatedChild,
      onEnter: (event) => setState(() => isHovering = true),
      onExit: (event) => setState(() => isHovering = false),
    );
  }
}
