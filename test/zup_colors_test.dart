import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_colors.dart';

void main() {
  test('ZupColors brand', () {
    expect(ZupColors.brand.value.toRadixString(16), 'ff7357ff');
  });

  test('ZupColors brand5', () {
    expect(ZupColors.brand5.value.toRadixString(16), 'ffd5cfff');
  });

  test('ZupColors tertiary', () {
    expect(ZupColors.tertiary.value.toRadixString(16), '12787880');
  });

  test('ZupColors black', () {
    expect(ZupColors.black.value.toRadixString(16), 'ff000000');
  });

  test('ZupColors black5', () {
    expect(ZupColors.black5.value.toRadixString(16), 'ff404040');
  });

  test('ZupColors white', () {
    expect(ZupColors.white.value.toRadixString(16), 'ffffffff');
  });

  test('ZupColors gray', () {
    expect(ZupColors.gray.value.toRadixString(16), 'ff8e8e93');
  });

  test('ZupColors gray4', () {
    expect(ZupColors.gray4.value.toRadixString(16), 'ffd1d1d6');
  });

  test('ZupColors gray5', () {
    expect(ZupColors.gray5.value.toRadixString(16), 'ffe5e5ea');
  });

  test('ZupColors red', () {
    expect(ZupColors.red.value.toRadixString(16), 'ffff3b30');
  });

  test('ZupColors red5', () {
    expect(ZupColors.red5.value.toRadixString(16), 'fffddcda');
  });

  test('ZupColors green', () {
    expect(ZupColors.green.value.toRadixString(16), 'ff34c759');
  });

  test('ZupColors green5', () {
    expect(ZupColors.green5.value.toRadixString(16), 'fff6fff8');
  });

  test('ZupColors blue', () {
    expect(ZupColors.blue.value.toRadixString(16), 'ff007aff');
  });

  test('ZupColors gray6', () {
    expect(ZupColors.gray6.value.toRadixString(16), 'fff7f7fc');
  });

  test('ZupColors brand6', () {
    expect(ZupColors.brand6.value.toRadixString(16), 'ffded7ff');
  });
}
