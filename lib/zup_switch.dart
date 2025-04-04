import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

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
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          activeTrackColor: ZupColors.brand,
          inactiveThumbColor: ZupColors.brand,
          inactiveTrackColor: ZupColors.gray5,
          thumbColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return ZupColors.gray4;
              }

              return value ? ZupColors.white : ZupColors.brand;
            },
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return ZupColors.gray5;
              }

              return value ? ZupColors.brand : ZupColors.gray5;
            },
          ),
          padding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
