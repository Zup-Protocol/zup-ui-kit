import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_colors.dart';

void main() {
  test('ZupColors brand', () {
    expect(ZupColors.brand.toARGB32().toRadixString(16), 'ff7357ff');
  });

  test('ZupColors brand5', () {
    expect(ZupColors.brand5.toARGB32().toRadixString(16), 'ffd5cfff');
  });

  test('ZupColors black', () {
    expect(ZupColors.black.toARGB32().toRadixString(16), 'ff000000');
  });

  test('ZupColors black5', () {
    expect(ZupColors.black5.toARGB32().toRadixString(16), 'ff48484a');
  });

  test('ZupColors white', () {
    expect(ZupColors.white.toARGB32().toRadixString(16), 'ffffffff');
  });

  test('ZupColors gray', () {
    expect(ZupColors.gray.toARGB32().toRadixString(16), 'ff8e8e93');
  });

  test('ZupColors gray4', () {
    expect(ZupColors.gray4.toARGB32().toRadixString(16), 'ffd4d4da');
  });

  test('ZupColors gray5', () {
    expect(ZupColors.gray5.toARGB32().toRadixString(16), 'ffe5e5ea');
  });

  test('ZupColors red', () {
    expect(ZupColors.red.toARGB32().toRadixString(16), 'ffff3b30');
  });

  test('ZupColors red5', () {
    expect(ZupColors.red5.toARGB32().toRadixString(16), 'fffddcda');
  });

  test('ZupColors green', () {
    expect(ZupColors.green.toARGB32().toRadixString(16), 'ff34c759');
  });

  test('ZupColors green5', () {
    expect(ZupColors.green5.toARGB32().toRadixString(16), 'ffebf2ed');
  });

  test('ZupColors blue', () {
    expect(ZupColors.blue.toARGB32().toRadixString(16), 'ff007aff');
  });

  test('ZupColors gray6', () {
    expect(ZupColors.gray6.toARGB32().toRadixString(16), 'fff7f7fc');
  });

  test('ZupColors brand6', () {
    expect(ZupColors.brand6.toARGB32().toRadixString(16), 'ffded7ff');
  });

  test('ZupColors brand7', () {
    expect(ZupColors.brand7.toARGB32().toRadixString(16), 'fff0ecff');
  });

  test("ZupColors orange", () {
    expect(ZupColors.orange.toARGB32().toRadixString(16), 'ffff9500');
  });

  test("ZupColors orange5", () {
    expect(ZupColors.orange5.toARGB32().toRadixString(16), 'ffffe5c0');
  });

  test("ZupColors orange6", () {
    expect(ZupColors.orange6.toARGB32().toRadixString(16), 'fffff2e0');
  });

  test("ZupColors red6", () {
    expect(ZupColors.red6.toARGB32().toRadixString(16), 'ffffedec');
  });
  test('ZupColors black2', () {
    expect(ZupColors.black2.toARGB32().toRadixString(16), 'ff161616');
  });

  test('ZupColors black3', () {
    expect(ZupColors.black3.toARGB32().toRadixString(16), 'ff1c1c1e');
  });

  test('ZupColors black4', () {
    expect(ZupColors.black4.toARGB32().toRadixString(16), 'ff3a3a3c');
  });

  test('ZupColors black6', () {
    expect(ZupColors.black6.toARGB32().toRadixString(16), 'ff5a5a5c');
  });

  test('ZupColors gray2', () {
    expect(ZupColors.gray2.toARGB32().toRadixString(16), 'ffa5a5aa');
  });

  test('ZupColors gray3', () {
    expect(ZupColors.gray3.toARGB32().toRadixString(16), 'ffc7c7cc');
  });

  test('ZupColors red2', () {
    expect(ZupColors.red2.toARGB32().toRadixString(16), 'ffff453a');
  });

  test('ZupColors red3', () {
    expect(ZupColors.red3.toARGB32().toRadixString(16), 'ffff605c');
  });

  test('ZupColors red4', () {
    expect(ZupColors.red4.toARGB32().toRadixString(16), 'ffff9f9d');
  });

  test('ZupColors green2', () {
    expect(ZupColors.green2.toARGB32().toRadixString(16), 'ff50c76e');
  });

  test('ZupColors green3', () {
    expect(ZupColors.green3.toARGB32().toRadixString(16), 'ff6cd98b');
  });

  test('ZupColors green4', () {
    expect(ZupColors.green4.toARGB32().toRadixString(16), 'ff91d6ab');
  });

  test('ZupColors orange2', () {
    expect(ZupColors.orange2.toARGB32().toRadixString(16), 'ffffa526');
  });

  test('ZupColors orange3', () {
    expect(ZupColors.orange3.toARGB32().toRadixString(16), 'ffffb74d');
  });

  test('ZupColors orange4', () {
    expect(ZupColors.orange4.toARGB32().toRadixString(16), 'ffffc46d');
  });
}
