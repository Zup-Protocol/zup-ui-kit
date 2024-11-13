import 'package:flutter/material.dart';
import 'package:zup_core/clippers/zup_half_clipper.dart';

class ZupMergedWidgets extends StatelessWidget {
  /// Show half of a given widget on the left and half of given widget on the right.
  /// Useful for representing a pair of something.
  ///
  /// Can be used with any widget
  const ZupMergedWidgets({super.key, required this.firstWidget, required this.secondWidget});

  /// The left widget of the [ZupMergedWidgets] that its right half will be clipped
  final Widget firstWidget;

  /// The right widget of the [ZupMergedWidgets] that its left half will be clipped
  final Widget secondWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: ClipPath(
            clipper: ZupHalfClipper(side: ZupHalfClipperSide.right),
            child: firstWidget,
          ),
        ),
        ClipPath(
          clipper: ZupHalfClipper(side: ZupHalfClipperSide.left),
          child: secondWidget,
        ),
      ],
    );
  }
}
