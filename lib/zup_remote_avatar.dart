import 'package:flutter/material.dart';
import 'package:zup_core/extensions/extensions.dart';
import 'package:zup_ui_kit/zup_circular_loading_indicator.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_network_image.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

/// A widget that displays an avatar image from a remote URL.
/// The image is loaded using the [ZupNetworkImage] and
/// displayed inside a [CircleAvatar] widget with some
/// personalized styling and handlings.
class ZupRemoteAvatar extends StatelessWidget {
  /// A widget that displays an avatar image from a remote URL.
  /// The image is loaded using the [ZupNetworkImage] and
  /// displayed inside a [CircleAvatar] widget with some
  /// personalized styling and handlings.
  const ZupRemoteAvatar({
    super.key,
    required this.avatarUrl,
    this.errorPlaceholder,
    this.zupNetworkImage,
    this.size = 30,
  });

  /// The URL of the image to display inside the avatar widget.

  /// This image will be fetched from the internet and displayed as a circular avatar.

  /// If the image fails to load, an error placeholder will be shown instead. The error placeholder can be customized by setting the [errorPlaceholder] property.
  final String avatarUrl;

  /// The size of the avatar widget in pixels, defaults to 30.
  ///
  /// This value represents the diameter of the avatar widget.
  ///
  /// If the image fails to load, the error placeholder will occupy the same size.
  final double size;

  /// An optional string placeholder to show when the image fails to load.
  ///
  /// If null, defaults to "?".
  ///
  /// Recommended to set the initials of the related image, like if it's
  /// an user avatar, use the user name initials as a error placeholder.
  ///
  /// For example, if the avatar is for a user named "John Doe", you can set
  /// the error placeholder to "JD".
  ///
  /// This string will be placed at the center of the avatar, and it will be
  /// rendered as a text widget.
  final String? errorPlaceholder;

  /// Optionally pass a custom [ZupNetworkImage] to use instead of the default one.
  ///
  /// This can be useful in a few scenarios:
  ///
  /// - To allow easy mocking of extenal images, making testing easier.
  /// - To stub the image loading method [ZupNetworkImage.load] to return a custom widget.
  /// - To use a different image loading method, if needed.
  final ZupNetworkImage? zupNetworkImage;

  Widget _genericAvatar(BuildContext context) => SizedBox(
    height: size,
    width: size,
    child: FittedBox(
      child: CircleAvatar(
        backgroundColor: ZupThemeColors.disabledButtonBackground.themed(context.brightness),
        foregroundColor: ZupColors.gray,
        child: Text(errorPlaceholder ?? "?"),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return avatarUrl.isEmpty
        ? _genericAvatar(context)
        : (zupNetworkImage ?? ZupNetworkImage()).load(
            context,
            avatarUrl,
            height: size,
            width: size,
            radius: size / 2,
            backgroundColor: Colors.white,
            errorWidget: (_, __, ___) => _genericAvatar(context),
            placeholder: ZupCircularLoadingIndicator(
              size: size,
              trackColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            ),
          );
  }
}
