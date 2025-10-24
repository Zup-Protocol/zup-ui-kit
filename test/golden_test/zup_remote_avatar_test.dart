import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zup_core/test_utils.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

import '../golden_config.dart';
import '../mocks.dart';

void main() {
  late ZupNetworkImage zupNetworkImage;

  setUp(() {
    zupNetworkImage = ZupNetworkImageMock();

    registerFallbackValue(BuildContextMock());

    when(
      () => zupNetworkImage.load(
        any(),
        any(),
        height: any(named: "height"),
        width: any(named: "width"),
        backgroundColor: any(named: "backgroundColor"),
        errorWidget: any(named: "errorWidget"),
        placeholder: any(named: "placeholder"),
        radius: any(named: "radius"),
      ),
    ).thenReturn(const Text("IMAGE"));
  });

  Future<DeviceBuilder> goldenBuilder({
    String? avatarUrl,
    String? errorPlaceholder,
    double? size,
    bool snapshotThemeModes = true,
  }) => goldenDeviceBuilder(
    snapshotThemeModes: snapshotThemeModes,
    ZupRemoteAvatar(
      avatarUrl: avatarUrl ?? "https://example.com/avatar.png",
      errorPlaceholder: errorPlaceholder,
      size: size ?? 30,
      zupNetworkImage: zupNetworkImage,
    ),
  );

  zGoldenTest(
    """When initializing the widget with a empty avatarUrl, it should display a generic avatar,
    using ? as the placeholder if no errorPlaceholder is provided""",
    goldenFileName: "zup_remote_avatar_empty_avatar_url",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(avatarUrl: ""));
    },
  );

  zGoldenTest(
    """When initializing the widget with a not empty avatarUrl, it should
  call .load in ZupNetworkImage to get the image and display it in the avatar
  with the background color white, the placeholder as the ZupCircularLoadingIndicator""",
    goldenFileName: "zup_remote_avatar_not_empty_avatar_url",
    (tester) async {
      when(
        () => zupNetworkImage.load(
          any(),
          any(),
          height: any(named: "height"),
          width: any(named: "width"),
          backgroundColor: any(named: "backgroundColor"),
          errorWidget: any(named: "errorWidget"),
          placeholder: any(named: "placeholder"),
          radius: any(named: "radius"),
        ),
      ).thenReturn(const Text("IMAGE FROM .LOAD"));

      await tester.pumpDeviceBuilder(
        await goldenBuilder(avatarUrl: "https://example.com/avatar.png", snapshotThemeModes: false),
      );

      verify(
        () => zupNetworkImage.load(
          any(),
          any(),
          height: any(named: "height"),
          width: any(named: "width"),
          backgroundColor: Colors.white,
          errorWidget: any(named: "errorWidget"),
          placeholder: any(named: "placeholder", that: isA<ZupCircularLoadingIndicator>()),
          radius: any(named: "radius"),
        ),
      ).called(1);
    },
  );

  zGoldenTest(
    "When passing the size param, and the avatarUrl is empty, it should also be applied to the generic avatar",
    goldenFileName: "zup_remote_avatar_empty_avatar_url_size",
    (tester) async {
      return tester.pumpDeviceBuilder(await goldenBuilder(avatarUrl: "", size: 500));
    },
  );

  zGoldenTest(
    """When passing the size param, and the avatarUrl is not empty, it should be repassed to .load in ZupNetworkImage
    as height and width, the radius should be half of the size, the size should also be passed to the placeholder""",
    (tester) async {
      const size = 500.0;
      await tester.pumpDeviceBuilder(
        await goldenBuilder(avatarUrl: "https://example.com/.png", size: size, snapshotThemeModes: false),
      );

      verify(
        () => zupNetworkImage.load(
          any(),
          any(),
          height: size,
          width: size,
          backgroundColor: any(named: "backgroundColor"),
          errorWidget: any(named: "errorWidget"),
          placeholder: any(
            named: "placeholder",
            that: matchesProperty((ZupCircularLoadingIndicator obj) => obj.size == size),
          ),
          radius: size / 2,
        ),
      ).called(1);
    },
  );
}
