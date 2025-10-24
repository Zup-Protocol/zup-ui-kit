import 'package:flutter/material.dart';
import 'package:zup_core/extensions/extensions.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

/// Object used to load images from a remote url, very useful to allow easy mocking of extenal images
///
/// Needs to be instanciated and used with [load] method in order to load an image
class ZupNetworkImage {
  /// Object used to load images from a remote url, very useful to allow easy mocking of extenal images
  ///
  /// Needs to be instanciated and used with [load] method in order to load an image
  ZupNetworkImage();

  String _parseImageUrl(String url) {
    if (url.startsWith("ipfs://")) return url.replaceFirst("ipfs://", "https://ipfs.io/ipfs/");

    return url;
  }

  /// Load an image from a remote url
  ///
  /// [url] The url of the image
  ///
  /// [height] Optionally set the height of the image
  ///
  /// [width] Optionally set the width of the image
  ///
  /// [radius] Optionally set the border radius of the image
  ///
  /// [placeholder] Optionally set a placeholder widget to be shown while the image is loading, if null a [ZupCircularLoadingIndicator] will be shown
  ///
  /// [errorWidget] Optionally set a custom error widget to be shown when the image fails to load, no default error widget will be shown.
  /// In case of an error, a exception will be thrown
  ///
  /// [fit] Optionally set the fit of the image, default is [BoxFit.cover]
  ///
  /// [backgroundColor] Optionally set the background color of the image, useful for images that have transparent backgrounds
  Widget load(
    BuildContext context,
    String url, {
    double? height,
    double? width,
    double? radius,
    Widget? placeholder,
    Color? backgroundColor,
    ImageErrorWidgetBuilder? errorWidget,
    BoxFit fit = BoxFit.cover,
  }) {
    return Container(
      key: ValueKey(url),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        border: Border.all(width: 0.5, color: ZupThemeColors.borderOnBackground.themed(context.brightness)),
      ),
      // cache not implemented yet because of web issue rendering images from other domains (https://github.com/Baseflow/flutter_cached_network_image/issues/972)
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Container(
          color: backgroundColor,
          child: Image.network(
            _parseImageUrl(url),
            height: height,
            width: width,
            fit: fit,
            errorBuilder: errorWidget,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (frame == null) {
                return Container(
                  color: ZupThemeColors.background.themed(context.brightness),
                  child: placeholder ?? ZupCircularLoadingIndicator(size: height ?? 20),
                );
              }
              return child;
            },
            webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
          ),
        ),
      ),
    );
  }
}
