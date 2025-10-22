# Zup UI Kit

Zup UI Kit is a Flutter library that makes building beautiful UIs simple and straightforward for any app. Powered by the [Zup Protocol App](https://app.zupprotocol.xyz).

⚠️ Please note: this library is still in development and currently only intended for use with Flutter Web.

<!-- ## Table of Contents

- [Installation](#installation) -->

## Installation

First of all, you need to install the package, so you can run:

```bash
flutter pub add zup_ui_kit
```

It will add the `zup_ui_kit` package to your project, directly under `pubspec.yaml`.

To ensure proper usage of the package, you should also apply the Zup theme in your MaterialApp:

```dart
MaterialApp(
  ...
  theme: ZupTheme.lightTheme,
  darkTheme: ZupTheme.darkTheme,
  ...
)
```

If you want to customize the theme, you can use the .copyWith() method to apply your own changes:

```dart
ZupTheme.lightTheme.copyWith(
  // ... your changes
);

ZupTheme.darkTheme.copyWith(
 //  ... your changes
);
```
