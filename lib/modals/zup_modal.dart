import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// Show a modal for the user.
///
/// Call the static method `.show` to display the modal from anywhere
class ZupModal extends StatelessWidget {
  const ZupModal({
    super.key,
    required this.child,
    required this.dismissible,
    required this.size,
    required this.title,
    required this.backgroundColor,
    required this.description,
    required this.padding,
    required this.isBottomSheet,
  });

  final Widget child;
  final bool dismissible;
  final Size size;
  final String? title;
  final Color? backgroundColor;
  final String? description;
  final EdgeInsetsGeometry? padding;
  final bool isBottomSheet;

  /// Show a modal for the user from the given context
  ///
  /// @param `context` -> the context that the modal should be displayed in
  ///
  /// @param `content` -> the content of the modal, not including title, description or close button
  ///
  /// @param `dismissible` -> whether the modal can be dismissed by tapping outside of it. Defaults to true
  ///
  /// @param `size` -> the size of the modal, defaults to 500x500. Note that if [showAsBottomSheet] is true,
  /// the width param will not work, as it will be set by default to occupy the whole width
  ///
  /// @param `title` -> the title of the modal. If null, the title will not be displayed
  ///
  /// @param `description` -> the description of the modal. If null, the description will not be displayed.
  /// Note that the title needs to be not null, in order to show the description
  ///
  /// @param `backgroundColor` -> the background color of the modal. Defaults to white
  ///
  /// @param `padding` -> the padding of the content inside the modal
  ///
  /// @param `showAsBottomSheet` -> whether to show the modal as a bottom sheet, useful to adapt the modal for mobile also. Defaults to false
  ///
  /// @param `useRootNavigator` -> whether to use the root navigator to show the modal. Defaults to true
  static Future<void> show(
    BuildContext context, {
    required Widget content,
    bool dismissible = true,
    Size size = const Size(500, 500),
    String? title,
    String? description,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    bool showAsBottomSheet = false,
    bool useRootNavigator = true,
  }) async {
    if (showAsBottomSheet) {
      return showModalBottomSheet(
        context: context,
        useRootNavigator: useRootNavigator,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: size.height),
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        sheetAnimationStyle: const AnimationStyle(
          curve: Curves.fastEaseInToSlowEaseOut,
          duration: Duration(milliseconds: 400),
          reverseCurve: Curves.fastOutSlowIn,
          reverseDuration: Duration(milliseconds: 300),
        ),
        builder: (context) => ZupModal(
          isBottomSheet: true,
          dismissible: dismissible,
          size: size,
          title: title,
          backgroundColor: backgroundColor,
          description: description,
          padding: padding,
          child: content,
        ),
      );
    }

    showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: ZupColors.black.withValues(alpha: context.brightness.isDark ? 0.8 : 0.5),
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.decelerate)),
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return ZupModal(
          padding: padding,
          isBottomSheet: false,
          backgroundColor: backgroundColor,
          description: description,
          dismissible: dismissible,
          size: size,
          title: title,
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(isBottomSheet ? 0 : 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isBottomSheet ? 0 : 18).copyWith(
            topLeft: isBottomSheet ? const Radius.circular(20) : null,
            topRight: isBottomSheet ? const Radius.circular(20) : null,
          ),
          color: backgroundColor ?? ZupThemeColors.background.themed(context.brightness),
        ),
        height: size.height,
        width: isBottomSheet ? double.maxFinite : size.width,
        child: ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SelectionArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                    child: Stack(
                      alignment: description != null ? Alignment.topLeft : Alignment.centerLeft,
                      children: [
                        if (title != null)
                          SizedBox(
                            width: size.width - (dismissible ? 140 : 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: ZupThemeColors.primaryText.themed(context.brightness),
                                  ),
                                ),
                                if (description != null)
                                  Text(
                                    description!,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: ZupColors.gray,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (dismissible) ...[
                          Align(
                            alignment: Alignment.topRight,
                            child: ZupIconButton(
                              icon: const Icon(Icons.close, size: 20, color: ZupColors.gray),
                              onPressed: Navigator.of(context).pop,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
