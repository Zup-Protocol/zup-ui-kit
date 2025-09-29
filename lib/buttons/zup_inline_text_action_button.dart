import 'package:flutter/material.dart';

/// Display a button that will trigger an action at the end of a sentence
///
/// Useful for displaying a helper button, after a helper text, to guide the user with some action
class ZupInlineTextActionButton extends StatelessWidget {
  const ZupInlineTextActionButton({
    super.key,
    required this.text,
    required this.onActionButtonPressed,
    required this.actionButtonTitle,
    this.style,
  });

  /// The sentence/text to be displayed before the button
  final String text;

  /// The title of the button after the text
  final String actionButtonTitle;

  /// Optionally pass an override style for the text. If null
  /// the default style will be used.
  ///
  /// Note that it will also be applied to the button, except for the color
  /// which will be set to the primary color of the theme
  final TextStyle? style;

  /// The action that will be triggered when the action button is pressed
  final void Function() onActionButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: '$text '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-5, 0),
              child: TextButton(
                key: const Key("zup-inline-action-button-button"),
                onPressed: onActionButtonPressed,
                style: ButtonStyle(padding: WidgetStateProperty.all(const EdgeInsets.all(6))),
                child: Text(
                  actionButtonTitle,
                  style: style?.copyWith(
                    color: Theme.of(context).primaryColor,
                    decorationColor: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
