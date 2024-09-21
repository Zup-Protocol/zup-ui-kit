import 'package:flutter/material.dart';
import 'package:zup_ui_kit/buttons/buttons.dart';
import 'package:zup_ui_kit/zup_colors.dart';

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
  });

  final Widget icon;
  final String title;
  final String? description;
  final String? helpButtonTitle;
  final Widget? helpButtonIcon;
  final double iconSize;
  final Function()? onHelpButtonTap;

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
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: iconSize,
              width: iconSize,
              child: FittedBox(
                fit: BoxFit.contain,
                child: icon,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: ZupColors.black),
        ),
        const SizedBox(height: 10),
        if (description != null)
          Text(
            description!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: ZupColors.gray),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 5),
        if (helpButtonTitle != null)
          ZupPrimaryButton(
            key: const Key("help-button"),
            title: helpButtonTitle!,
            fontWeight: FontWeight.w500,
            foregroundColor: Theme.of(context).primaryColor,
            onPressed: onHelpButtonTap ?? () {},
            backgroundColor: Colors.transparent,
            hoverElevation: 0,
            icon: helpButtonIcon,
          )
      ],
    );
  }
}
