import 'package:flutter/material.dart';
import 'package:zup_core/zup_core.dart';
import 'package:zup_ui_kit/src/gen/assets.gen.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// A side panel widget that slides in from the right of the screen.
///
/// Use [ZupSidePanel.show] to show the side panel, and pass in a [child] widget to display inside the side panel
class ZupSidePanel extends StatefulWidget {
  const ZupSidePanel._({required this.child});

  final Widget child;

  /// Open the side panel with the given child widget as the content
  static Future<void> show(BuildContext context, {required Widget child}) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (_, __, ___) => ZupSidePanel._(child: child),
      barrierColor: Colors.black.withValues(alpha: 0.3),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 600),
      transitionBuilder: (_, animation, __, child) => FadeTransition(
        opacity: Tween(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut)),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.2, 0),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: animation, curve: Curves.fastEaseInToSlowEaseOut)),
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.decelerate)),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  State<ZupSidePanel> createState() => _ZupSidePanelState();
}

class _ZupSidePanelState extends State<ZupSidePanel> {
  double childWidth = 0;
  final double borderRadius = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(child: GestureDetector(onTap: () => Navigator.pop(context))),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(left: 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: SelectionArea(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SizedBox(
                      width: childWidth + 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: Material(
                            color: ZupColors.gray4.withValues(alpha: context.brightness.isDark ? 0.05 : 0.4),
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              hoverColor: ZupThemeColors.hoverOnBackgroundSurface
                                  .themed(context.brightness)
                                  .withValues(alpha: 0.2),
                              splashColor: ZupThemeColors.splashOnBackgroundSurface
                                  .themed(context.brightness)
                                  .withValues(alpha: 0.3),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Assets.icons.chevronRightDottedChevronRight.svg(
                                    colorFilter: const ColorFilter.mode(ZupColors.white, BlendMode.srcIn),
                                    package: "zup_ui_kit",
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Builder(
                        builder: (context) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (childWidth != context.size?.width) {
                              setState(() => childWidth = context.size?.width ?? 0);
                            }
                          });

                          return Container(
                            decoration: BoxDecoration(
                              color: ZupThemeColors.background.themed(context.brightness),
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            height: double.infinity,
                            child: widget.child,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
