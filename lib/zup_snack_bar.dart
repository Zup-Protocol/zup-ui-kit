import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// The type of the [ZupSnackBar] to be displayed. Based on each type it will change its color and icon
enum ZupSnackBarType { error, success, info }

extension _ZupSnackBarTypeExtension on ZupSnackBarType {
  Color color(BuildContext context) {
    if (context.brightness.isDark) return ZupColors.black2;

    return [ZupColors.red5, Theme.of(context).primaryColor.lighter(0.9), ZupColors.gray5][index];
  }

  Color textColor(BuildContext context) => [
    ZupThemeColors.error.themed(context.brightness),
    context.brightness.isDark ? Theme.of(context).primaryColor.lighter(0.5) : Theme.of(context).primaryColor,
    context.brightness.isDark ? ZupColors.gray3 : ZupColors.black5,
  ][index];

  Widget get icon => [
    Assets.icons.exclamationmarkTriangle.svg(package: "zup_ui_kit"),
    Assets.icons.checkmark.svg(package: "zup_ui_kit"),
    Assets.icons.infoCircle.svg(package: "zup_ui_kit"),
  ][index];

  Curve get animationCurve =>
      [Curves.fastOutSlowIn, Curves.fastEaseInToSlowEaseOut, Curves.fastEaseInToSlowEaseOut][index];
}

class ZupSnackBar extends SnackBar {
  const ZupSnackBar(
    this.context, {
    super.key,
    required this.message,
    this.customIcon,
    this.helperButton,
    this.hideCloseIcon = false,
    this.snackDuration = const Duration(seconds: 5),
    this.type = ZupSnackBarType.error,
    this.maxWidth = double.infinity,
  }) : super(content: const SizedBox.shrink());

  /// The type of the [ZupSnackBar] to be displayed. Based on each type it will change its color and icon
  final ZupSnackBarType type;

  /// The message to be displayed in the Snack bar
  final String message;

  /// Whether to hide the close icon or not. Defaults to false
  final bool hideCloseIcon;

  /// Params for a possible helper button to have in the end of the Snack bar message.
  /// If null, the button will not be displayed
  ///
  /// `title`: The title of the button to be shown
  /// `onButtonTap`: The function to be called when the button is pressed
  final ({String title, Function() onButtonTap})? helperButton;

  /// Current scaffold context
  final BuildContext context;

  /// Custom icon to be added in the snack bar. If null, it will choose the default for each type
  final Widget? customIcon;

  /// The display duration of the snack bar. If null, it will choose 5 seconds by default
  final Duration snackDuration;

  /// The max width of the Snack bar, defaults to infinity, so it will fill the entire context.
  ///
  /// Note that is not a fixed width, if the context is smaller than the max width, it will not exceed it.
  final double maxWidth;

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
  DismissDirection? get dismissDirection => DismissDirection.none;

  @override
  Widget get content => ExcludeSemantics(
    child: Center(
      child:
          Container(
            width: maxWidth,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: type.color(context), borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ColorFiltered(
                  colorFilter: ColorFilter.mode(type.textColor(context), BlendMode.srcATop),
                  child: customIcon ?? type.icon,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: message,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: type.textColor(context)),
                        ),
                        if (helperButton != null)
                          WidgetSpan(
                            child: MouseRegion(
                              key: const Key("helper-button-snack-bar"),
                              cursor: SystemMouseCursors.click,
                              child: InkWell(
                                onTap: () => helperButton!.onButtonTap(),
                                child: IgnorePointer(
                                  child: SizedBox(
                                    height: 19,
                                    child: Text(
                                      helperButton!.title,
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: type.textColor(context),
                                        color: type.textColor(context),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (!hideCloseIcon) ...[
                  const SizedBox(width: 20),
                  ZupIconButton(
                    key: const Key("close-snack-bar"),
                    backgroundColor: type.textColor(context).withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(6),
                    icon: Icon(Icons.close, size: 16, color: type.textColor(context)),
                    onPressed: (_) => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  ),
                ],
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
                ),
            ],
          ),
    ),
  );
}
