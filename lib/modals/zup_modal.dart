import 'package:flutter/material.dart';
import 'package:zup_ui_kit/buttons/buttons.dart';
import 'package:zup_ui_kit/zup_colors.dart';

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
  });

  final Widget child;
  final bool dismissible;
  final Size size;
  final String? title;
  final Color? backgroundColor;
  final String? description;
  final EdgeInsetsGeometry? padding;

  /// Show a modal for the user from the given context
  ///
  /// @param `context` -> the context that the modal should be displayed in
  ///
  /// @param `content` -> the content of the modal, not including title, description or close button
  ///
  /// @param `dismissible` -> whether the modal can be dismissed by tapping outside of it. Defaults to true
  ///
  /// @param `size` -> the size of the modal, defaults to 500x500
  ///
  /// @param `title` -> the title of the modal. If null, the title will not be displayed
  ///
  /// @param `description` -> the description of the modal. If null, the description will not be displayed.
  /// Note that the title needs to be not null, in order to show the description
  ///
  /// @param `backgroundColor` -> the background color of the modal. Defaults to white
  ///
  /// @param `padding` -> the padding of the content inside the modal
  static Future<void> show(
    BuildContext context, {
    required Widget content,
    bool dismissible = true,
    Size size = const Size(500, 500),
    String? title,
    String? description,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
  }) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismissible,
      barrierLabel: "zup-modal",
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.decelerate,
          ),
          child: animation.value > 0.6 ? child : null,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return ZupModal(
          padding: padding,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: backgroundColor ?? Colors.white,
        ),
        height: size.height,
        width: size.width,
        child: ScaffoldMessenger(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                  child: Stack(
                    alignment: description != null ? Alignment.topLeft : Alignment.centerLeft,
                    children: [
                      if (title != null)
                        SizedBox(
                          width: size.width - (dismissible ? 100 : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                title!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: ZupColors.black,
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
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: Navigator.of(context).pop,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: Padding(
                  padding: padding ?? EdgeInsets.zero,
                  child: child,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
