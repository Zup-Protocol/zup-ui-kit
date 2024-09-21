import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zup_ui_kit/buttons/zup_icon_button.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';
import 'package:zup_ui_kit/zup_colors.dart';

/// The type of the [ZupSnackBar] to be displayed. Based on each type it will change its color and icon
enum ZupSnackBarType { error, success, info }

extension _ZupSnackBarTypeExtension on ZupSnackBarType {
  Color get color => [
        ZupColors.red5,
        ZupColors.green5,
        ZupColors.gray5,
      ][index];

  Color get textColor => [
        ZupColors.red,
        ZupColors.green,
        ZupColors.black5,
      ][index];

  Widget get icon => [
        Assets.icons.xmark.svg(package: "zup_ui_kit"),
        Assets.icons.checkmark.svg(package: "zup_ui_kit"),
        Assets.icons.infoCircle.svg(package: "zup_ui_kit"),
      ][index];

  Curve get animationCurve => [
        Curves.fastOutSlowIn,
        Curves.fastEaseInToSlowEaseOut,
        Curves.fastEaseInToSlowEaseOut,
      ][index];
}

class ZupSnackBar extends SnackBar {
  const ZupSnackBar(
    this.context, {
    super.key,
    required this.message,
    this.customIcon,
    super.showCloseIcon,
    this.snackDuration = const Duration(seconds: 5),
    this.type = ZupSnackBarType.error,
  }) : super(content: const SizedBox.shrink());

  /// The type of the [ZupSnackBar] to be displayed. Based on each type it will change its color and icon
  final ZupSnackBarType type;

  /// The message to be displayed in the Snack bar
  final String message;

  /// Current scaffold context
  final BuildContext context;

  /// Custom icon to be added in the snack bar. If null, it will choose the default for each type
  final Widget? customIcon;

  /// The display duration of the snack bar. If null, it will choose 5 seconds by default
  final Duration snackDuration;

  final int animationDuration = 600;

  @override
  Color get backgroundColor => Colors.transparent;

  @override
  double get elevation => 0;

  @override
  SnackBarBehavior get behavior => SnackBarBehavior.fixed;

  @override
  Duration get duration => snackDuration;

  @override
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(20);

  @override
  Widget get content => ExcludeSemantics(
        child: Container(
          width: 50,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: type.color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(type.textColor, BlendMode.srcATop),
                child: customIcon ?? type.icon,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: type.textColor),
                ),
              ),
              if (showCloseIcon ?? true) ...[
                const SizedBox(width: 20),
                ZupIconButton(
                  backgroundColor: type.textColor.withOpacity(0.1),
                  iconColor: type.textColor,
                  padding: const EdgeInsets.all(6),
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                ),
              ]
            ],
          ),
        ).animate(
          effects: [
            SlideEffect(
              curve: type.animationCurve,
              duration: Duration(milliseconds: animationDuration),
              begin: const Offset(0, 2),
              end: Offset.zero,
            ),
            if (type == ZupSnackBarType.error)
              ShakeEffect(
                hz: 10,
                rotation: 0,
                offset: const Offset(3, 0),
                duration: const Duration(milliseconds: 300),
                delay: Duration(milliseconds: animationDuration - 200),
              )
          ],
        ),
      );
}
