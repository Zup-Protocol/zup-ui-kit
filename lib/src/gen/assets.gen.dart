/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow.clockwise.svg
  SvgGenImage get arrowClockwise => const SvgGenImage('assets/icons/arrow.clockwise.svg');

  /// File path: assets/icons/checkmark.circle.fill.svg
  SvgGenImage get checkmarkCircleFill => const SvgGenImage('assets/icons/checkmark.circle.fill.svg');

  /// File path: assets/icons/checkmark.svg
  SvgGenImage get checkmark => const SvgGenImage('assets/icons/checkmark.svg');

  /// File path: assets/icons/chevron.up.chevron.down.svg
  SvgGenImage get chevronUpChevronDown => const SvgGenImage('assets/icons/chevron.up.chevron.down.svg');

  /// File path: assets/icons/exclamationmark.triangle.svg
  SvgGenImage get exclamationmarkTriangle => const SvgGenImage('assets/icons/exclamationmark.triangle.svg');

  /// File path: assets/icons/info.circle.svg
  SvgGenImage get infoCircle => const SvgGenImage('assets/icons/info.circle.svg');

  /// File path: assets/icons/x.circle.svg
  SvgGenImage get xCircle => const SvgGenImage('assets/icons/x.circle.svg');

  /// File path: assets/icons/xmark.svg
  SvgGenImage get xmark => const SvgGenImage('assets/icons/xmark.svg');

  /// List of all assets
  List<SvgGenImage> get values => [arrowClockwise, checkmarkCircleFill, checkmark, chevronUpChevronDown, exclamationmarkTriangle, infoCircle, xCircle, xmark];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
