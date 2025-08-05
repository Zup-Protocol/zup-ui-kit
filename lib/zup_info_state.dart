import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/buttons/buttons.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// Shows an info state to the user. Generally displayed when something is Empty, or an error occurs.
///
/// It also have the possibility to contain a helper button, in order to guide the user with some action
class ZupInfoState extends StatelessWidget {
  const ZupInfoState({
    super.key,
    required this.icon,
    required this.title,
    this.helpButtonTitle,
    this.helpButtonIcon,
    this.onHelpButtonTap,
    this.description,
    this.iconSize = 140,
    this.helpButtonSpacing = 5,
    this.iconSpacing = 30,
  });

  /// The Main icon to be displayed
  final Widget icon;

  /// The size of the main icon
  final double iconSize;

  /// The title used for the state
  final String title;

  /// The description of the state. Talking about why it happened, or what to do.
  final String? description;

  /// The title of the helper button, If null it will not display the button.
  final String? helpButtonTitle;

  /// The icon of the helper button. If null it will not display any icon.
  final Widget? helpButtonIcon;

  /// Callback to be executed when the user taps on the help button
  final Function()? onHelpButtonTap;

  /// The vertical spacing between the text and the help button, defaults to 5
  final double helpButtonSpacing;

  /// The vertical spacing between the icon and the title
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: iconSize / 2,
              width: iconSize / 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    spreadRadius: 20,
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: FittedBox(fit: BoxFit.contain, child: icon),
            ),
          ],
        ),
        SizedBox(height: iconSpacing),
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: ZupThemeColors.primaryText.themed(context.brightness),
          ),
        ),
        if (description != null)
          Text(
            description!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ZupColors.gray),
            textAlign: TextAlign.center,
          ),
        SizedBox(height: helpButtonSpacing),
        if (helpButtonTitle != null)
          ZupPrimaryButton(
            key: const Key("help-button"),
            title: helpButtonTitle!,
            fontWeight: FontWeight.w500,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: onHelpButtonTap != null ? (buttonContext) => onHelpButtonTap!() : null,
            backgroundColor: Colors.transparent,
            hoverElevation: 0,
            icon: helpButtonIcon,
          ),
      ],
    );
  }
}
