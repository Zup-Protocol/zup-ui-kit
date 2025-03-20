import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zup_ui_kit/buttons/zup_icon_button.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';

class ZupRefreshButton extends StatefulWidget {
  /// Build an animated refresh styled icon button from the Zup UI Kit.
  const ZupRefreshButton({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.size = 20,
    this.animationController,
  });

  /// Callback when the button is pressed.
  /// Use the Future in the callback to set when the button
  /// animation should start and stop. While this function is
  /// being executed, the button will be animated (rotating), so you can
  /// control it using `await` for example
  final Future Function() onPressed;

  /// A custom color for the refresh icon. Defaults to [ZupIconButton] icon color
  final Color? iconColor;

  /// The size of the refresh icon (which also sets the button size). Defaults to 20
  final double size;

  /// A custom animation controller to use for the rotating animation in cases that
  /// the animation needs to be controlled from outside the button also
  final AnimationController? animationController;

  @override
  State<ZupRefreshButton> createState() => _ZupRefreshButtonState();
}

class _ZupRefreshButtonState extends State<ZupRefreshButton> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 100),
        );
  }

  @override
  void dispose() {
    if (widget.animationController == null) animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZupIconButton(
      key: const Key("refresh-button"),
      backgroundColor: Colors.transparent,
      iconColor: widget.iconColor,
      icon: Assets.icons.arrowClockwise.svg(
        width: widget.size,
        height: widget.size,
        package: "zup_ui_kit",
      ),
      onPressed: () async {
        animationController?.repeat();
        await widget.onPressed();
        if (animationController?.status != AnimationStatus.completed) animationController?.forward();
      },
    ).animate(autoPlay: false, controller: animationController, effects: [
      const RotateEffect(
        duration: Duration(milliseconds: 500),
        begin: 0,
        end: 1,
      )
    ]);
  }
}
