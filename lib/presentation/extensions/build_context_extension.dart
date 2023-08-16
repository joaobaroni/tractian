import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ///
  /// Get [MediaQueryData] from current context
  ///
  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  ///
  /// Get current screen width, based on current context
  ///
  double get screenWidth {
    return mediaQuery.size.width;
  }

  ///
  /// Get current screen height, based on current context
  ///
  double get screenHeight {
    return mediaQuery.size.height;
  }
}
