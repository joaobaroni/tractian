import 'package:flutter/material.dart';

///
/// Theme extensions for colors on BuildContext
///
extension ThemeExtension on BuildContext {
  /// Returns the [ColorScheme] implementation based on current theme
  /// brightness associated to the current context.
  ColorScheme get colorPalette => Theme.of(this).colorScheme;

  /// Theme for this context
  ThemeData get theme => Theme.of(this);

  /// TextTheme for this context
  TextTheme get textTheme => Theme.of(this).textTheme;
}
