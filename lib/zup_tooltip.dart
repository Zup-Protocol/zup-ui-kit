import 'package:flutter/material.dart';
import 'package:zup_ui_kit/zup_colors.dart';

class ZupTooltip extends StatefulWidget {
  /// Create a tooltip that displays a message when hovering its child
  ///
  /// Useful for displaying information on hover
  const ZupTooltip._({
    super.key,
    required this.child,
    required this.padding,
    this.message,
    this.leadingIcon,
    this.tooltipChild,
    this.trailingIcon,
    this.helperButtonOnPressed,
    this.helperButtonTitle,
    this.constraints = const BoxConstraints(maxWidth: 300),
  });

  factory ZupTooltip.text({
    Key? key,
    required Widget child,
    required String message,
    Widget? leadingIcon,
    Widget? trailingIcon,
    dynamic Function()? helperButtonOnPressed,
    String? helperButtonTitle,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 300),
  }) => ZupTooltip._(
    key: key,
    padding: 8,
    leadingIcon: leadingIcon,
    trailingIcon: trailingIcon,
    message: message,
    constraints: constraints,
    helperButtonOnPressed: helperButtonOnPressed,
    helperButtonTitle: helperButtonTitle,
    child: child,
  );

  factory ZupTooltip.widget({
    Key? key,
    required Widget child,
    required Widget tooltipChild,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 300),
  }) => ZupTooltip._(key: key, padding: 0, tooltipChild: tooltipChild, constraints: constraints, child: child);

  /// Child that will show the tooltip once hovered
  final Widget child;

  /// Message to display once the tooltip is being shown
  final String? message;

  final Widget? tooltipChild;

  /// Optional leading icon to show with the message
  final Widget? leadingIcon;

  /// Optional trailing icon to show with the message
  final Widget? trailingIcon;

  /// Optional title for the helper button, if null
  /// a helper button will not be shown
  ///
  /// This helper button will appear right after the message,
  /// its very useful to put a button to guide the user with some action
  final String? helperButtonTitle;

  /// Optional Function that will be called once the helper button is pressed
  final Function()? helperButtonOnPressed;

  /// The maximum width of the tooltip box when the message is being shown, defaults to 300
  final BoxConstraints constraints;

  final double padding;

  @override
  State<ZupTooltip> createState() => _ZupTooltipState();
}

class _ZupTooltipState extends State<ZupTooltip> {
  bool isHoveringHelperButton = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      richMessage: TextSpan(
        children: [
          WidgetSpan(
            child: ConstrainedBox(
              constraints: widget.constraints,
              child:
                  widget.tooltipChild ??
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(color: ZupColors.gray, fontSize: 14),
                      children: [
                        if (widget.leadingIcon != null)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: SizedBox(width: 16, height: 16, child: FittedBox(child: widget.leadingIcon!)),
                            ),
                          ),
                        TextSpan(text: widget.message),
                        if (widget.trailingIcon != null)
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: SizedBox(width: 16, height: 16, child: FittedBox(child: widget.trailingIcon!)),
                            ),
                          ),
                        if (widget.helperButtonTitle != null)
                          WidgetSpan(
                            child: MouseRegion(
                              key: const Key("helper-button-tooltip"),
                              cursor: SystemMouseCursors.click,
                              onEnter: (event) => setState(() => isHoveringHelperButton = true),
                              onExit: (event) => setState(() => isHoveringHelperButton = false),
                              child: GestureDetector(
                                onTap: () {
                                  widget.helperButtonOnPressed?.call();
                                  setState(() => isHoveringHelperButton = false);
                                },
                                child: SizedBox(
                                  height: 18,
                                  child: Text(
                                    widget.helperButtonTitle ?? "",
                                    style: TextStyle(
                                      color: isHoveringHelperButton ? ZupColors.black : Theme.of(context).primaryColor,
                                      fontSize: 14,
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
          ),
        ],
      ),
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        color: ZupColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZupColors.gray4, width: 1),
      ),
      child: widget.child,
    );
  }
}
