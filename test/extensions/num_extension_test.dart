import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zup_ui_kit/zup_ui_kit.dart';

void main() {
  testWidgets(
    "When calling 'trendColor' with a positive number, and light mode, it should return [ZupThemeColors.success] light color",
    (tester) async {
      BuildContext? context0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Center(
            child: Builder(
              builder: (context) {
                context0 = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(1.trendColor(context0!), ZupThemeColors.success.lightColor);
    },
  );

  testWidgets(
    "When calling 'trendColor' with a positive number, and dark mode, it should return [ZupThemeColors.success] dark color",
    (tester) async {
      BuildContext? context0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Center(
            child: Builder(
              builder: (context) {
                context0 = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect(1.trendColor(context0!), ZupThemeColors.success.darkColor);
    },
  );

  testWidgets(
    "When calling 'trendColor' with a negative number, and light mode, it should return [ZupThemeColors.error] light color",
    (tester) async {
      BuildContext? context0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Center(
            child: Builder(
              builder: (context) {
                context0 = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect((-1).trendColor(context0!), ZupThemeColors.error.lightColor);
    },
  );

  testWidgets(
    "When calling 'trendColor' with a negative number, and dark mode, it should return [ZupThemeColors.error] dark color",
    (tester) async {
      BuildContext? context0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Center(
            child: Builder(
              builder: (context) {
                context0 = context;
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      expect((-1).trendColor(context0!), ZupThemeColors.error.darkColor);
    },
  );

  testWidgets("When calling 'trendColor' with 0, it should return [ZupColors.gray]", (tester) async {
    BuildContext? context0;

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Center(
          child: Builder(
            builder: (context) {
              context0 = context;
              return const SizedBox();
            },
          ),
        ),
      ),
    );

    expect(0.trendColor(context0!), ZupColors.gray);
  });
}
