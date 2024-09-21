# Zup UI Kit

Zup UI Kit is a Flutter library containing all the UI components for the [Zup app](https://app.zupprotocol.xyz). Also powering UI Kits for the [web3kit Flutter Package]().

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Buttons](#buttons)
  - [Zup Primary Button](#zup-primary-button)
  - [Zup Icon Button](#zup-icon-button)
- [Modals](#modals)
  - [Zup Modal](#zup-modal)
- [Other](#other)
  - [Zup Colors](#zup-colors)
  - [Zup Info State](#zup-info-state)
  - [Zup Snack Bar](#zup-snack-bar)

## Installation

First of all, you need to install the package, so you can run:

```bash
flutter pub add zup_ui_kit
```

It will add the `zup_ui_kit` package to your project, directly under `pubspec.yaml`

## Usage

Using the Zup UI Kit is very simple. You can use the following components:

### Buttons

#### Zup Primary Button

Display the main button from Zup UI Kit. To display it, first import the `ZupPrimaryButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_primary_button.dart';
```

and then place it inside the widget tree:

```dart
ZupPrimaryButton(title: "String", onPressed: () {});
```

it has the following parameters:

```dart
/// The background color of the button. If null, the color will be derived from the theme, using the primary color
final Color? backgroundColor;

/// The foreground color of the button. If null, the default color will be white.
final Color? foregroundColor;

/// The icon to be displayed in the side of the button. If null, the icon will not be displayed
final Widget? icon;

/// The title to be displayed in the button
final String title;

/// The font weight of the title, defaults to w600 when active, and w400 when not active
final FontWeight? fontWeight;

/// A custom border to be used in the button. By default it does not have any border
final BorderSide? border;

/// The elevation of the button when hovered. By default it is 14
final double hoverElevation;

/// Whether the icon should be fixed in the button (show the icon always), or should be animated (show the icon only on hover). Defaults to false
final bool fixedIcon;

/// Whether the button is in loading state. Defaults to false. If true it will show a loading indicator
final bool isLoading;

/// Whether to make the button fill the whole available space or only the minimum space. Defaults to minimum
final MainAxisSize mainAxisSize;

/// The function to be called when the button is pressed. If null, the button will be in inactive state
final Function()? onPressed;
```

#### Zup Icon Button

Display an icon button from Zup UI Kit. To display it, first import the `ZupIconButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_icon_button.dart';
```

and then place it inside the widget tree:

```dart
ZupIconButton(icon: ANY_WIDGET, onPressed: () {});
```

it has the following parameters:

```dart
/// The main icon to show in the button.
final Widget icon;

/// The background color of the button. If null, the background color will be derived from ZupColors, using [ZupColors.tertiary] as default.
final Color? backgroundColor;

/// The icon color of the button. If null, the icon color will be derived from ZupColors, using [ZupColors.gray] as default.
final Color? iconColor;

/// The padding of the button, defaults to 6 on all sides.
final EdgeInsetsGeometry? padding;

/// The callback that is called when the button is pressed. If null, the button will be in inactive state
final Function()? onPressed;
```

### Modals

#### Zup Modal

Display a modal from Zup UI Kit. To display it, first import the `ZupModal` widget:

```dart
import 'package:zup_ui_kit/modals/zup_modal.dart';
```

and then use it inside a function call, by calling the static method `ZupModal.show()`:

```dart
ZupModal.show(context, content: ANY_WIDGET);
```

it has the following parameters:

```dart
/// The context that the modal should be displayed in
final BuildContext context;

/// The content of the modal, not including title, description or close button
final Widget content;

/// Whether the modal can be dismissed by tapping outside of it. Defaults to true
final bool dismissible;

/// The size of the modal, defaults to 500x500
final Size size;

/// The title of the modal. If null, the title will not be displayed
final String? title;

/// The description of the modal. If null, the description will not be displayed.
/// Note that the title needs to be not null, in order to show the description
final String? description;

/// The background color of the modal. Defaults to white
final Color? backgroundColor;

/// The padding of the content inside the modal
final EdgeInsetsGeometry? padding;
```

### Other

#### Zup Colors

Display a color from Zup UI Kit. To display it, first import the `ZupColors` class:

```dart
import 'package:zup_ui_kit/zup_colors.dart';
```

and then use it wherever it you need to put a color, by calling the static method `ZupColors.[color]`:

```dart
ZupColors.brand;
```

Available colors:

- brand
- tertiary
- black
- black5
- white
- gray
- gray4
- gray5
- red
- red5
- green
- green5
- blue

#### Zup Info State

Display an info state from Zup UI Kit. To display it, first import the `ZupInfoState` class:

```dart
import 'package:zup_ui_kit/zup_info_state.dart';
```

and then use it wherever it you need to put an info state in your widget tree, by using the object `ZupInfoState`:

```dart
ZupInfoState(title: "String", icon: ANY_WIDGET)
```

it has the following parameters:

```dart
/// The Main icon to be displayed
final Widget icon;

/// The size of the main icon
final double iconSize;

/// The title used for the state
final String title;

/// The description of the state. Talking about why it happened, or what to do.
final String? description;

/// The title of the helper button, If null it will not display the button.
final String? helpButtonTitle;

/// The icon of the helper button. If null it will not display any icon.
final Widget? helpButtonIcon;

/// Callback to be executed when the user taps on the help button
final Function()? onHelpButtonTap;
```

#### Zup Snack Bar

Display a snack bar from Zup UI Kit. To display it, first import the `ZupSnackBar` class:

```dart
import 'package:zup_ui_kit/zup_snack_bar.dart';
```

and then use it wherever it you need to show a snack bar. by using the regular method to show a snack bar:

```dart
ScaffoldMessenger.of(context).showSnackBar(ZupSnackBar(context, message: "String"));
```

it has the following parameters:

```dart
/// The type of the [ZupSnackBar] to be displayed. Based on each type it will change its color and icon
final ZupSnackBarType type;

/// The message to be displayed in the Snack bar
final String message;

/// Current scaffold context
final BuildContext context;

/// Custom icon to be added in the snack bar. If null, it will choose the default for each type
final Widget? customIcon;

/// The display duration of the snack bar. If null, it will choose 5 seconds by default
final Duration snackDuration;
```
