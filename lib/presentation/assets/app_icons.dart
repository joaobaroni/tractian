import 'package:flutter/material.dart';

///
/// The AppIcons class is an abstract class that defines custom font icons for use in an application.
///
abstract class AppIcons {
  static const _kFontFam = 'tractianicons';

  /// Save Icon
  static const IconData save = IconData(0xe901, fontFamily: _kFontFam);

  /// Cube Icon
  static const IconData cube = IconData(0xe900, fontFamily: _kFontFam);

  /// Asset Icon
  static const IconData asset = IconData(0xe902, fontFamily: _kFontFam);

  /// Machine Icon
  static const IconData machine = IconData(0xe903, fontFamily: _kFontFam);

  /// Word Order Large Icon
  static const IconData workOrderLarge = IconData(0xe904, fontFamily: _kFontFam);

  /// Add Work Order Icon
  static const IconData addWorkOrder = IconData(0xe905, fontFamily: _kFontFam);

  /// QRCode Icon
  static const IconData qrCode = IconData(0xe906, fontFamily: _kFontFam);

  /// Tractian Icon
  static const IconData tractian = IconData(0xe907, fontFamily: _kFontFam);

  /// Open Orders Icon
  static const IconData openOrders = IconData(0xe908, fontFamily: _kFontFam);

  /// Sensor Icon
  static const IconData sensor = IconData(0xe909, fontFamily: _kFontFam);

  /// Health Icon
  static const IconData health = IconData(0xe90a, fontFamily: _kFontFam);

  /// Status Icon
  static const IconData status = IconData(0xe90d, fontFamily: _kFontFam);

  /// Roller Icon
  static const IconData roller = IconData(0xe90e, fontFamily: _kFontFam);

  /// Location Icon
  static const IconData location = IconData(0xe90f, fontFamily: _kFontFam);

  /// Arrow Icon
  static const IconData arrow = IconData(0xe910, fontFamily: _kFontFam);
}
