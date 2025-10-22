import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

class ZupSwitchingIconButton extends StatefulWidget {
  /// Show an icon button that will switch its rest icon once pressed, then switch back
  /// to the rest icon after a given duration
  ///
  /// Useful for displaying buttons with a immediate feedback for the user,
  /// like a like, bookmark, copy, etc...
  const ZupSwitchingIconButton({
    super.key,
    required this.restIcon,
    required this.pressedIcon,
    required this.onPressed,
    this.backgroundColor,
    this.circle = true,
    this.pressedIconDuration,
    this.padding,
    this.restIconTooltipMessage,
    this.pressedIconTooltipMessage,
  });

  /// The icon to show when the button is not pressed, the primary icon
  final Widget restIcon;

  /// The icon to show when the button is pressed, a temporary icon that will
  /// be shown for a given duration
  final Widget pressedIcon;

  /// Optionally set the background color of the button, default is transparent
  final Color? backgroundColor;

  /// Set if the button should be circular, defaults to true
  final bool circle;

  /// Optionally set a custom padding for the button
  final EdgeInsetsGeometry? padding;

  /// The function to be called when the button is pressed
  final Function(BuildContext buttonContext) onPressed;

  /// The duration of the pressed icon state before switching back to the rest icon, defaults to 3 seconds
  final Duration? pressedIconDuration;

  /// Optionally set a tooltip message to show when the button is hovered with the icon as the rest icon
  final String? restIconTooltipMessage;

  /// Optionally set a tooltip message to show when the button is hovered with the icon as the pressed icon
  final String? pressedIconTooltipMessage;

  @override
  State<ZupSwitchingIconButton> createState() => _ZupSwitchingIconButtonState();
}

class _ZupSwitchingIconButtonState extends State<ZupSwitchingIconButton> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;

  void showSecondIconTemporarily() {
    setState(() => crossFadeState = CrossFadeState.showSecond);

    Future.delayed(widget.pressedIconDuration ?? const Duration(seconds: 3), () {
      setState(() => crossFadeState = CrossFadeState.showFirst);
    });
  }

  String get tooltipMessage {
    if (crossFadeState == CrossFadeState.showFirst) return widget.restIconTooltipMessage ?? "";

    return widget.pressedIconTooltipMessage ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ZupTooltip.text(
      message: tooltipMessage,
      child: ZupIconButton(
        backgroundColor: widget.backgroundColor ?? Colors.transparent,
        padding: widget.padding,
        circle: widget.circle,
        icon: AnimatedCrossFade(
          firstChild: widget.restIcon,
          secondChild: widget.pressedIcon,
          crossFadeState: crossFadeState,
          duration: const Duration(milliseconds: 100),
        ),
        onPressed: (context) {
          if (crossFadeState == CrossFadeState.showFirst) showSecondIconTemporarily();

          widget.onPressed(context);
        },
      ),
    );
  }
}
