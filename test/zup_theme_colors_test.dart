import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_colors.dart';
import 'package:zup_ui_kit/zup_theme_colors.dart';

void main() {
  test("When calling 'background' light color, it should return the correct color", () {
    expect(ZupThemeColors.background.lightColor, ZupColors.white);
  });

  test("When calling 'background' dark color, it should return the correct color", () {
    expect(ZupThemeColors.background.darkColor, const Color.fromARGB(255, 17, 17, 17));
  });

  test("When calling 'primaryText' light color, it should return the correct color", () {
    expect(ZupThemeColors.primaryText.lightColor, ZupColors.black);
  });

  test("When calling 'primaryText' dark color, it should return the correct color", () {
    expect(ZupThemeColors.primaryText.darkColor, ZupColors.gray4);
  });

  test("When calling 'disabledText' light color, it should return the correct color", () {
    expect(ZupThemeColors.disabledText.lightColor, ZupColors.gray5);
  });

  test("When calling 'disabledText' dark color, it should return the correct color", () {
    expect(ZupThemeColors.disabledText.darkColor, ZupColors.black5);
  });

  test("When calling 'backgroundSurface' light color, it should return the correct color", () {
    expect(ZupThemeColors.backgroundSurface.lightColor, ZupColors.white);
  });

  test("When calling 'backgroundSurface' dark color, it should return the correct color", () {
    expect(ZupThemeColors.backgroundSurface.darkColor, ZupColors.black3);
  });

  test("When calling 'borderOnBackground' light color, it should return the correct color", () {
    expect(ZupThemeColors.borderOnBackground.lightColor, ZupColors.gray5);
  });

  test("When calling 'borderOnBackground' dark color, it should return the correct color", () {
    expect(ZupThemeColors.borderOnBackground.darkColor, ZupColors.black3);
  });

  test("When calling 'hoverOnBackground' light color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnBackground.lightColor, ZupColors.gray6);
  });

  test("When calling 'hoverOnBackground' dark color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnBackground.darkColor, ZupColors.black3);
  });

  test("When calling 'iconColor' light color, it should return the correct color", () {
    expect(ZupThemeColors.iconColor.lightColor, ZupColors.black);
  });

  test("When calling 'iconColor' dark color, it should return the correct color", () {
    expect(ZupThemeColors.iconColor.darkColor, ZupColors.white);
  });

  test("When calling 'splashOnBackground' light color, it should return the correct color", () {
    expect(ZupThemeColors.splashOnBackground.lightColor, ZupColors.gray5);
  });

  test("When calling 'splashOnBackground' dark color, it should return the correct color", () {
    expect(ZupThemeColors.splashOnBackground.darkColor, ZupColors.gray);
  });

  test("When calling 'hoverOnBackgroundSurface' light color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnBackgroundSurface.lightColor, ZupColors.gray6);
  });

  test("When calling 'hoverOnBackgroundSurface' dark color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnBackgroundSurface.darkColor, ZupColors.black4);
  });

  test("When calling 'tertiaryButtonBackground' light color, it should return the correct color", () {
    expect(ZupThemeColors.tertiaryButtonBackground.lightColor, ZupColors.gray6);
  });

  test("When calling 'tertiaryButtonBackground' dark color, it should return the correct color", () {
    expect(ZupThemeColors.tertiaryButtonBackground.darkColor, ZupColors.black3);
  });

  test("When calling 'disabledButtonBackground' light color, it should return the correct color", () {
    expect(ZupThemeColors.disabledButtonBackground.lightColor, ZupColors.gray5);
  });

  test("When calling 'disabledButtonBackground' dark color, it should return the correct color", () {
    expect(ZupThemeColors.disabledButtonBackground.darkColor, ZupColors.black4);
  });

  test("When calling 'hoverOnTertiaryButton' light color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnTertiaryButton.lightColor, ZupColors.gray5.withValues(alpha: 0.4));
  });

  test("When calling 'hoverOnTertiaryButton' dark color, it should return the correct color", () {
    expect(ZupThemeColors.hoverOnTertiaryButton.darkColor, ZupColors.black4);
  });

  test("When calling 'splashOnBackgroundSurface' light color, it should return the correct color", () {
    expect(ZupThemeColors.splashOnBackgroundSurface.lightColor, ZupColors.gray5);
  });

  test("When calling 'splashOnBackgroundSurface' dark color, it should return the correct color", () {
    expect(ZupThemeColors.splashOnBackgroundSurface.darkColor, ZupColors.black5);
  });

  test("When calling 'error' light color, it should return the correct color", () {
    expect(ZupThemeColors.error.lightColor, ZupColors.red);
  });

  test("When calling 'error' dark color, it should return the correct color", () {
    expect(ZupThemeColors.error.darkColor, ZupColors.red3);
  });

  test("When calling 'borderOnBackgroundSurface' light color, it should return the correct color", () {
    expect(ZupThemeColors.borderOnBackgroundSurface.lightColor, ZupColors.gray5);
  });

  test("When calling 'borderOnBackgroundSurface' dark color, it should return the correct color", () {
    expect(ZupThemeColors.borderOnBackgroundSurface.darkColor, ZupColors.black4);
  });

  test("When calling 'alert' light color, it should return the correct color", () {
    expect(ZupThemeColors.alert.lightColor, ZupColors.orange);
  });

  test("When calling 'alert' dark color, it should return the correct color", () {
    expect(ZupThemeColors.alert.darkColor, ZupColors.orange3);
  });

  test("When calling 'shimmer' light color, it should return the correct color", () {
    expect(ZupThemeColors.shimmer.lightColor, ZupColors.gray5);
  });

  test("When calling 'shimmer' dark color, it should return the correct color", () {
    expect(ZupThemeColors.shimmer.darkColor, ZupColors.black5);
  });

  test("When calling 'backgroundInverse' light color, it should return the correct color", () {
    expect(ZupThemeColors.backgroundInverse.lightColor, ZupColors.black);
  });

  test("When calling 'backgroundInverse' dark color, it should return the correct color", () {
    expect(ZupThemeColors.backgroundInverse.darkColor, ZupColors.white);
  });

  test("When calling 'success' light color, it should return the correct color", () {
    expect(ZupThemeColors.success.lightColor, ZupColors.green);
  });

  test("When calling 'success' dark color, it should return the correct color", () {
    expect(ZupThemeColors.success.darkColor, ZupColors.green3);
  });

  test("When using 'themed' for a color, and passing light brightness, it should return the light color", () {
    expect(ZupThemeColors.background.themed(Brightness.light), ZupThemeColors.background.lightColor);
  });

  test("When using 'themed' for a color, and passing dark brightness, it should return the dark color", () {
    expect(ZupThemeColors.background.themed(Brightness.dark), ZupThemeColors.background.darkColor);
  });
}
