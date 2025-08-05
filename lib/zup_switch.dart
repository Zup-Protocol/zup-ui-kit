import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Creates a switch widget from the Zup UI Kit.
class ZupSwitch extends StatelessWidget {
  /// Creates a switch widget from the Zup UI Kit.
  const ZupSwitch({super.key, required this.value, required this.onChanged, this.size = 40});

  /// The value of the switch. If true, the switch is on. If false, the switch is off.
  final bool value;

  /// The callback that is called when the switch is toggled. If null, the switch is disabled.
  final void Function(bool)? onChanged;

  /// The size of the switch. The default size is 40.
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        child: Switch(
          value: value,
          onChanged: onChanged,
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          trackOutlineColor: WidgetStatePropertyAll(
            value ? Colors.transparent : ZupThemeColors.borderOnBackground.themed(context.brightness),
          ),
          activeTrackColor: Theme.of(context).primaryColor,
          inactiveThumbColor: Theme.of(context).primaryColor,
          inactiveTrackColor: ZupColors.gray5,
          hoverColor: context.brightness.isLight
              ? ZupColors.black.withValues(alpha: 0.05)
              : ZupColors.white.withValues(alpha: 0.05),
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return ZupColors.gray4;
            }

            return value ? ZupColors.white : Theme.of(context).primaryColor;
          }),
          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return ZupColors.gray5;
            }

            return value
                ? Theme.of(context).primaryColor
                : ZupThemeColors.tertiaryButtonBackground.themed(context.brightness);
          }),
          padding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
