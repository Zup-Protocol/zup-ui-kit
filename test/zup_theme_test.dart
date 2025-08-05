import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

void main() {
  test("The light theme should have the correct brightness for the light mode", () {
    expect(ZupTheme.lightTheme.brightness, Brightness.light);
  });

  test("The dark theme should have the correct brightness for the dark mode", () {
    expect(ZupTheme.darkTheme.brightness, Brightness.dark);
  });

  test("The dark theme should have the correct scaffold color", () {
    expect(ZupTheme.darkTheme.scaffoldBackgroundColor, ZupThemeColors.background.darkColor);
  });

  test("The light theme should have the correct scaffold color", () {
    expect(ZupTheme.lightTheme.scaffoldBackgroundColor, ZupThemeColors.background.lightColor);
  });
}
