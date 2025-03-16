# Zup UI Kit

Zup UI Kit is a Flutter library containing all the UI components for the [Zup app](https://app.zupprotocol.xyz). Also powering UI Kits for the [web3kit Flutter Package]().

⚠️ This library is intended to be used for Flutter Web!

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Buttons](#buttons)
  - [Zup Primary Button](#zup-primary-button)
  - [Zup Icon Button](#zup-icon-button)
  - [Zup Popup Menu Button](#zup-popup-menu-button)
  - [Zup Mini Button](#zup-mini-button)
  - [Zup Pill Button](#zup-pill-button)
  - [Zup Light Button](#zup-light-button)
  - [Zup Refresh Button](#zup-refresh-button)
- [Modals](#modals)
  - [Zup Modal](#zup-modal)
- [Other](#other)
  - [Zup Colors](#zup-colors)
  - [Zup Info State](#zup-info-state)
  - [Zup Snack Bar](#zup-snack-bar)
  - [Zup Tag](#zup-tag)
  - [Zup Text Field](#zup-text-field)
  - [Zup Tooltip](#zup-tooltip)
  - [Zup Stepped Loading](#zup-stepped-loading)
  - [Zup Merged Widgets](#zup-merged-widgets)
  - [Zup Selectable Card](#zup-selectable-card)
  - [Zup Dropdown](#zup-dropdown)

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

![Zup Primary Button Showcase](https://github.com/user-attachments/assets/cdd0a0f8-e082-414a-a11a-730f5e01d7c7)

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

/// The padding of the button. If null it will be 20 by default, for all sides
final EdgeInsets padding;

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

/// The maximum height of the button. Defaults to 50
final double height;

/// Whether to make the button fill the whole available space or only the minimum space. Defaults to minimum
final MainAxisSize mainAxisSize;

/// The function to be called when the button is pressed. If null, the button will be in inactive state
final Function()? onPressed;

/// Whether the button text & icon should be in the center of the button. Defaults to false
final bool alignCenter;

/// The width of the button. If null, the button will be as tight as possible
final double? width;

/// Choose whether to display an icon in the trailing side of the button or the leading side.
/// Defaults to false
final bool isTrailingIcon;
```

#### Zup Icon Button

![Zup Icon Button Showcase](https://github.com/user-attachments/assets/e0a9dbd4-21c5-4591-8287-515723b58a75)

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

/// The border of the button. If null, the button will not have a border
final BorderSide? borderSide;

/// The padding of the button, defaults to 6 on all sides.
final EdgeInsetsGeometry? padding;

/// The callback that is called when the button is pressed. If null, the button will be in inactive state
final Function()? onPressed;
```

#### Zup Popup Menu Button

![Zup Popup Menu Button Showcase](https://github.com/user-attachments/assets/9287dfd3-1061-4e41-8720-91c149c44048)

display a dropdown-like button that open a menu and let the user select an item. To display it, first import the `ZupPopupMenuButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_popup_menu_button.dart';
```

and then place it inside the widget tree:

```dart
return ZupPopupMenuButton(
  initialSelectedIndex: Int,
  items: List<ZupPopupMenuItem>,
  onSelected: Function(int selectedIndex),
);
```

it has the following parameters:

```dart
/// The initial selected item index, the one that will be visible in the button
final int initialSelectedIndex;

/// The list of items to show in the menu, when clicking the button
final List<ZupPopupMenuItem> items;

/// Callback which is called when any item is selected
final Function(int selectedIndex) onSelected;

/// Whether to close the menu when an item is selected or to keep it open
final bool closeOnSelection;

/// The height of the button to show the menu
final double buttonHeight;
```

#### Zup Mini Button

![Zup Mini Button showcase](https://github.com/user-attachments/assets/4641202f-785a-4f99-999a-429836aa1b4e)

Display a small size button from Zup UI Kit. To display it, first import the `ZupMiniButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_mini_button.dart';
```

and then place it inside the widget tree:

```dart
ZupMiniButton(
  title: "String",
)
```

it has the following parameters:

```dart
/// the left icon of the button, it will not be displayed if null
final Widget? icon;

/// the title of the button to be displayed
final String title;

/// the size of the passed [icon]. By default it is 16
final double iconSize;

/// the function to be called when the button is pressed
final void Function()? onPressed;
```

#### Zup Pill Button

![zup_pill_button](https://github.com/user-attachments/assets/314c4758-ec6a-49dd-8beb-be21a9867185)

Display a pill-style button from Zup UI Kit. To display it, first import the `ZupPillButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_pill_button.dart';
```

and then place it inside the widget tree:

```dart
ZupPillButton(
  title: "String",
  icon: ANY_WIDGET,
);
```

it has the following parameters:

```dart
/// The background color of the button, where the text will be placed at. Defaults to [ZupColors.brand7]
final Color backgroundColor;

/// The color of the text, and of the icon background in the button (If an icon is provided). Defaults to [ZupColors.brand]
///
/// Note that if there's no text in the button, the passed background color will be applied to the icon background instead
/// of using the passed foreground color, and the foreground color will be applied to the icon itself
final Color foregroundColor;

/// An optional icon to de displayed at the left side of the button, besides the title
final Widget? icon;

/// An optional title to be displayed at the center of the button
final String? title;

/// The callback to be called once the button is pressed
final void Function(BuildContext buttonContext) onPressed;
```

#### Zup Light Button

![Zup Light Button Showcase](https://github.com/user-attachments/assets/3ff8edb1-de02-46be-b932-9d91ee126673)
![Zup Light Button Showcase](https://github.com/user-attachments/assets/8bca0011-65b9-4437-8fcb-bc139d833cc9)

Display a button that change its child color when hovered, otherwise it keep the child in a rest color. To display it, first import the `ZupLightButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_light_button.dart';
```

and then place it inside the widget tree:

```dart
ZupLightButton(
  child: ANY_WIDGET,
  onPressed: () {},
);
```

it has the following parameters:

```dart
/// The child to be used in the button, can be a text, icon or any other widget
final Widget child;

/// The color to be used when the button is not hovered, note that it will be forced in the child. Defaults to [ZupColors.gray4]
final Color? restColor;

/// The color to be used when the button is hovered, note that it will be forced in the child. Defaults to [ZupColors.black]
final Color? hoverColor;

/// The function to be called when the button is pressed
final Function() onPressed;
```

#### Zup Refresh Button

![Zup Refresh Button Showcase](https://github.com/user-attachments/assets/7d8a8b5b-2c3e-4e0c-8a5b-2d4e0c8a5b2c)

Display a refresh button from Zup UI Kit. To display it, first import the `ZupRefreshButton` widget:

```dart
import 'package:zup_ui_kit/buttons/zup_refresh_button.dart';
```

and then place it inside the widget tree:

```dart
ZupRefreshButton(
  onPressed: () {},
);
```

it has the following parameters:

```dart
  /// Callback when the button is pressed.
  /// Use the Future in the callback to set when the button
  /// animation should start and stop. While this function is
  /// being executed, the button will be animated (rotating), so you can
  /// control it using `await` for example
  final Future Function() onPressed;

  /// A custom color for the refresh icon. Defaults to [ZupIconButton] icon color
  final Color? iconColor;

  /// The size of the refresh icon (which also sets the button size). Defaults to 20
  final double size;

  /// A custom animation controller to use for the rotating animation in cases that
  /// the animation needs to be controlled from outside the button also
  final AnimationController? animationController;
```

### Modals

#### Zup Modal

<img width="300" alt="Zup Modal Showcase" src="https://github.com/user-attachments/assets/cabc317b-3338-44f6-802f-70c3ab06243f">

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
- brand5
- brand6
- brand7
- tertiary
- black
- black5
- white
- gray
- gray4
- gray5
- gray6
- red
- red5
- red6
- green
- green5
- blue
- orange
- orange5
- orange6

#### Zup Info State

<img width="300" alt="Zup Info State Showcase" src="https://github.com/user-attachments/assets/dd4b5259-2ca9-4e4c-a51e-60284eb88af8">

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

/// The vertical spacing between the text and the help button, defaults to 5
final double helpButtonSpacing;
```

#### Zup Snack Bar

<img width="1438" alt="Zup Snack Bar Showcase" src="https://github.com/user-attachments/assets/19e5f5bd-77f3-4082-906f-f1136c0c2088">

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

/// Whether to hide the close icon or not. Defaults to false
///
/// **`note`**: A hidden close icon will not allow the user to dismiss the snack bar manually
final bool hideCloseIcon;

/// Params for a possible helper button to have in the end of the Snack bar message.
/// If null, the button will not be displayed
///
/// `title`: The title of the button to be shown
/// `onButtonTap`: The function to be called when the button is pressed
final ({String title, Function() onButtonTap})? helperButton;

/// Custom icon to be added in the snack bar. If null, it will choose the default for each type
final Widget? customIcon;

/// The display duration of the snack bar. If null, it will choose 5 seconds by default
final Duration snackDuration;
```

#### Zup Tag

<img width="300" alt="Zup Tag Showcase" src="https://github.com/user-attachments/assets/5dabd4bb-4d26-4689-973e-13de62347f43">

Display a tag from Zup UI Kit. To display it, first import the `ZupTag` class:

```dart
import 'package:zup_ui_kit/zup_tag.dart';
```

and then use it wherever it you need to put a tag in your widget tree, by using the object `ZupTag`:

```dart
ZupTag(title: "String", color: ANY_COLOR)
```

it has the following parameters:

```dart
/// The text to be displayed inside the tag
final String title;

/// The main color of the tag
final Color color;

/// The icon to be displayed next to the title
final Widget? icon;

/// Whether to apply the color passed in [color] to the icon, defaults to true
final bool applyColorToIcon;

/// The size of the icon, defaults to 16. Note that the icon size will not change the tag height,
/// if the icon size is too big, it will likely throw an overflow error
final double iconSize;

/// The horizontal spacing between the icon and the title, defaults to 8
final double iconSpacing;


/// The maximum height of the tag, defaults to 28
final double maxHeight;

/// The padding of the tag, defaults to 2 vertical and 10 horizontal
final EdgeInsetsGeometry? padding;
```

#### Zup Text Field

<img width="300" alt="Textfield showcase default" src="https://github.com/user-attachments/assets/3f3e6506-6e79-4f74-afe2-91af5bb75724">
<img width="300" alt="Textfield showcase with text" src="https://github.com/user-attachments/assets/7c1cf76b-8394-4a8e-b9c4-cd2b365b037a">

Display a text field from Zup UI Kit. To display it, first import the `ZupTextField` class:

```dart
import 'package:zup_ui_kit/zup_text_field.dart';
```

and then use it wherever it you need to put a text field in your widget tree, by using the object `ZupTextField`:

```dart
ZupTextField()
```

it has the following parameters:

```dart
/// the hint text that will be displayed in the text field, when it is empty
final String? hintText;

/// Called immediately when a value is typed in the textfield
final Function(String)? onChanged;
```

#### Zup Tooltip

<img width="300" alt="Zup Stepped Loading Showcase" src="https://github.com/user-attachments/assets/b2bf1954-b689-486e-9684-8bf51f314d82">

Display a tooltip from Zup UI Kit when the user hovers over a widget. To display it, first import the `ZupTooltip` class:

```dart
import 'package:zup_ui_kit/zup_tooltip.dart';
```

and then use it wherever it you need to put a tooltip in your widget tree, by using the object `ZupTooltip`:

```dart
ZupTooltip(
  message: "String",
  child: ANY_WIDGET,
)
```

it has the following parameters:

```dart
/// Child that will show the tooltip once hovered
final Widget child;

/// Message to display once the tooltip is being shown
final String message;

/// Optional leading icon to show with the message
final Widget? leadingIcon;

/// Optional trailing icon to show with the message
final Widget? trailingIcon;

/// Optional title for the helper button, if null
/// a helper button will not be shown
///
/// This helper button will appear right after the message,
/// its very useful to put a button to guide the user with some action
final String? helperButtonTitle;

/// Optional Function that will be called once the helper button is pressed
final Function()? helperButtonOnPressed;

/// The maximum width of the tooltip box when the message is being shown, defaults to 300
final double maxWidth;
```

#### Zup Stepped Loading

<img width="300" alt="Zup Stepped Loading Showcase" src="https://github.com/user-attachments/assets/2ad3c039-5b33-488d-8112-f5bdf4379b37">

Display a loading widget with steps (e.g Preparing, Scanning, Fetching). To display it, first import the `ZupSteppedLoading` class:

```dart
import 'package:zup_ui_kit/zup_stepped_loading.dart';
```

and then use it wherever it you need to put a loading in your widget tree, by using the object `ZupSteppedLoading`:

```dart
ZupSteppedLoading(
  steps: [Instance of `ZupSteppedLoadingStep`],
)
```

it has the following parameters:

```dart
/// List of steps to display while the loading is in progress.
///
/// The last step is the one that will remain active on the screen if the loading is still in progress
/// but all the step has already been displayed
final List<ZupSteppedLoadingStep> steps;

/// The duration that each step should remain on the screen. After this duration, it will
/// animate to the next step. Defaults to 5 seconds
final Duration stepDuration;

/// the constraints of the whole widget. Defaults to a max width of 400
final BoxConstraints constraints;
```

#### Zup Merged Widgets

<img width="300" alt="Zup Merged Widgets Showcase" src="https://github.com/user-attachments/assets/915f3088-1b21-4abd-aa3a-52e47f1a6522">

Display a widget that will cut half of two passed widgets and merge them horizontally. To display it, first import the `ZupMergedWidgets` class:

```dart
import 'package:zup_ui_kit/zup_merged_widgets.dart';
```

and then use it wherever it you need to put a merged widget in your widget tree, by using the object `ZupMergedWidgets`:

```dart
ZupMergedWidgets(
  firstWidget: ANY_WIDGET,
  secondWidget: ANY_WIDGET,
)
```

it has the following parameters:

```dart
/// The left widget of the [ZupMergedWidgets] that its right half will be clipped
final Widget firstWidget;

/// The right widget of the [ZupMergedWidgets] that its left half will be clipped
final Widget secondWidget;

/// The horizontal spacing betten the two widgets, defaults to 8
final double spacing;
```

#### Zup Selectable Card

<img width="300" alt="Selectable Card Showcase" src="https://github.com/user-attachments/assets/bd67b9fc-bf0f-4e05-874a-92e9d497da7b">

Display a selectable card from Zup UI Kit. To display it, first import the `ZupSelectableCard` class:

```dart
import 'package:zup_ui_kit/zup_selectable_card.dart';
```

and then use it wherever it you need to put a selectable card in your widget tree, by using the object `ZupSelectableCard`:

```dart
ZupSelectableCard(
  child: ANY_WIDGET,
)
```

it has the following parameters:

```dart
/// The child widget that will be displayed inside the card
final Widget child;

/// Whether the card should be in the selected state or not. Defaults to false
final bool isSelected;

/// The inside padding of the card, padding between the child and the card edges.
/// Defaults to 20 in all directions
final EdgeInsetsGeometry padding;

/// The function that will be called when the card is pressed
final Function()? onPressed;

/// The duration of the card selection animation, defaults to 200ms
final Duration selectionAnimationDuration;

/// Gives a fixed width to the card, defaults to null, so it will adapt to the content width
final double? width;
```

#### Zup Dropdown

Simply display a dropdown from anywhere, below a given context. To display it, first import the `ZupDropdown` class:

```dart
import 'package:zup_ui_kit/zup_dropdown.dart';
```

and then use it wherever it you need to put a dropdown in your screen, by using the object `ZupDropdown` and it's static method [ZupDropdown.show]:

```dart
ZupDropdown.show(
  showBelowContext: context,
  child: ANY_WIDGET,
)
```

it has the following parameters:

```dart
/// The child widget that will be displayed inside the dropdown
final Widget child;

/// The context that the dropdown should be displayed below, usually the context of a button. It will be used to calculate the position of the dropdown
/// Based on its parent (using the context passed)
final BuildContext showBelowContext
```
