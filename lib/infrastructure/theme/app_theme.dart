import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
/// Defines the default Light and Dark themes.
///
class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  /// Current [AppTheme] singleton instance
  static AppTheme get instance => _instance;

  ThemeData? _lightTheme;
  ThemeData? _darkTheme;

  ///
  /// Current Light theme definition
  ///
  ThemeData get lightTheme {
    _lightTheme ??= builder(
      seedColor: const Color(0xFF4E57A9),
      brightness: Brightness.light,
    );
    return _lightTheme!;
  }

  set lightTheme(ThemeData value) {
    _lightTheme = value;
  }

  ///
  /// Current Dark theme definition
  ///
  ThemeData get darkTheme {
    _darkTheme ??= builder(
      seedColor: const Color(0xFFBDC2FF),
      brightness: Brightness.dark,
    );

    return _darkTheme!;
  }

  set darkTheme(ThemeData value) {
    _darkTheme = value;
  }

  ///
  /// Builds a theme, based on the provided colors.
  ///
  ThemeData builder({
    required Color seedColor,
    required Brightness brightness,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      canvasColor: Colors.transparent,
      textTheme: GoogleFonts.sourceSansProTextTheme(),
      colorSchemeSeed: seedColor,
    );
  }
}
