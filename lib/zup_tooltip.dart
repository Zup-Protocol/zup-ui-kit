import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

class ZupTooltip extends StatefulWidget {
  const ZupTooltip._({
    super.key,
    required this.child,
    required double padding,
    required this.isChildBounded,
    this.message,
    this.leadingIcon,
    this.tooltipChild,
    this.trailingIcon,
    this.helperButtonOnPressed,
    this.helperButtonTitle,
    this.delay,
    this.margin,
    this.constraints = const BoxConstraints(maxWidth: 300),
  }) : _padding = padding;

  /// Create a tooltip that displays a message when hovering its child
  ///
  /// Useful for displaying information on hover
  ///
  /// `child`: the widget that will trigger the tooltip on hover or tap
  ///
  /// `message`: the message to be shown on hover, in case of being empty, the tooltip will not be shown
  ///
  /// `leadingIcon`: optionally show an icon at the leading side of the tooltip message
  ///
  /// `trailingIcon`: optionally show an icon at the trailing side of the tooltip message
  ///
  /// `helperButtonTitle`: Optionally show a helper button at the end of the tooltip message
  ///  with the given title that will trigger the [onHelperButtonPressed] callback.
  ///
  /// `onHelperButtonPressed`: The action to be handled once the helper button is pressed
  ///
  /// `delay`: The duration to wait before showing the tooltip, defaults to no delay
  ///
  /// `constraints`: The constraints of the tooltip box, defaults to max 300 width
  ///
  /// `isChildBounded`: Whether the tooltip should stay visible only while the mouse is hovering over the child widget.
  /// When `true`, the tooltip will disappear as soon as the pointer leaves the child area, even if the pointer moves
  /// into the tooltip itself. When `false`, hovering over the tooltip box will keep it visible until the mouse leaves
  /// both the child and the tooltip area or the user clicks elsewhere.
  ///
  /// `margin`: The margin to be applied to the tooltip box relative to the child, defaults to no margin
  factory ZupTooltip.text({
    Key? key,
    required Widget child,
    required String message,
    Widget? leadingIcon,
    Widget? trailingIcon,
    String? helperButtonTitle,
    dynamic Function()? onHelperButtonPressed,
    Duration? delay,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 300),
    bool isChildBounded = true,
    EdgeInsetsGeometry? margin,
  }) {
    if (helperButtonTitle != null && onHelperButtonPressed == null) {
      throw ArgumentError("onHelperButtonPressed must not be null when adding a helperButtonTitle");
    }

    if ((helperButtonTitle != null || onHelperButtonPressed != null) && isChildBounded) {
      throw ArgumentError("Cannot have both: helper button and isChildBounded set to true");
    }

    return ZupTooltip._(
      key: key,
      padding: 8,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      message: message,
      constraints: constraints,
      helperButtonOnPressed: onHelperButtonPressed,
      helperButtonTitle: helperButtonTitle,
      delay: delay,
      isChildBounded: isChildBounded,
      margin: margin,
      child: child,
    );
  }

  /// Create a tooltip that displays any widget when hovering its child
  ///
  /// Useful for displaying a custom widget on hover
  ///
  /// `child`: the widget that will trigger the tooltip on hover or tap
  ///
  /// `tooltipChild`: the widget to be shown on hover inside the tooltip
  ///
  /// `delay`: The duration to wait before showing the tooltip, defaults to no delay
  ///
  /// `constraints`: The constraints of the tooltip box, defaults to max 300 width
  ///
  /// `margin`: The margin to be applied to the tooltip box relative to the child, defaults to no margin
  ///
  /// `isChildBounded`: Whether the tooltip should stay visible only while the mouse is hovering over the child widget.
  /// When `true`, the tooltip will disappear as soon as the pointer leaves the child area, even if the pointer moves
  /// into the tooltip itself. When `false`, hovering over the tooltip box will keep it visible until the mouse leaves
  /// both the child and the tooltip area or the user clicks elsewhere.
  factory ZupTooltip.widget({
    Key? key,
    required Widget child,
    required Widget tooltipChild,
    Duration? delay,
    BoxConstraints constraints = const BoxConstraints(maxWidth: 300),
    EdgeInsetsGeometry? margin,
    bool isChildBounded = false,
  }) => ZupTooltip._(
    key: key,
    padding: 0,
    tooltipChild: tooltipChild,
    constraints: constraints,
    delay: delay,
    margin: margin,
    isChildBounded: isChildBounded,
    child: child,
  );

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

  /// The constraints of the tooltip box when the message is being shown
  final BoxConstraints constraints;

  /// The duration to wait before showing the tooltip
  final Duration? delay;

  /// The padding of the tooltip box, relative to the child
  final double _padding;

  /// The margin of the tooltip box relative to the child
  final EdgeInsetsGeometry? margin;

  /// Whether the tooltip should stay visible only while the mouse is hovering over the child widget.
  ///
  /// When `true`, the tooltip will disappear as soon as the pointer leaves the child area,
  /// even if the pointer moves into the tooltip itself.
  ///
  /// When `false`, hovering over the tooltip box will keep it visible until the mouse leaves
  /// both the child and the tooltip area or the user clicks elsewhere.
  final bool isChildBounded;

  @override
  State<ZupTooltip> createState() => _ZupTooltipState();
}

class _ZupTooltipState extends State<ZupTooltip> {
  bool isHoveringHelperButton = false;

  @override
  Widget build(BuildContext context) {
    if (widget.tooltipChild == null && (widget.message?.isEmpty ?? true)) return widget.child;

    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      waitDuration: widget.delay,
      enableTapToDismiss: !widget.isChildBounded,
      ignorePointer: widget.isChildBounded,
      margin: widget.margin,
      exitDuration: widget.isChildBounded ? Duration.zero : null,
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
                                      color: isHoveringHelperButton
                                          ? ZupThemeColors.primaryText.themed(context.brightness)
                                          : Theme.of(context).primaryColor,
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
      padding: EdgeInsets.all(widget._padding),
      decoration: BoxDecoration(
        color: ZupThemeColors.backgroundSurface.themed(context.brightness),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ZupThemeColors.borderOnBackgroundSurface.themed(context.brightness), width: 1),
      ),
      child: widget.child,
    );
  }
}
