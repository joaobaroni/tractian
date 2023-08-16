import 'package:flutter/cupertino.dart';

class SizeConfig {
  /// The value of [screen width] of design given by [designer]
  late int designScreenWidth;

  /// The value of [screen height] of design given by [designer]
  late int designScreenHeight;

  SizeConfig._({
    required this.designScreenHeight,
    required this.designScreenWidth,
  });

  factory SizeConfig.init() {
    return SizeConfig._(
      designScreenHeight: 812,
      designScreenWidth: 375,
    );
  }

  /// Width of current device
  static late double _screenWidth;

  /// Height of current device
  static late double _screenHeight;

  /// Value to initialize [fontSize]
  static double textMultiplier = 1;

  /// Value to initialize [image sizes]
  static double imageSizeMultiplier = 1;

  /// Value to initialize [height] values
  static double heightMultiplier = 1;

  /// Value to initialize [width] values
  static double widthMultiplier = 1;

  /// Value to get information about [orientation]
  static bool isPortrait = true;

  /// Value to get information about [portrait] in [mobile] or [not]
  static bool isMobilePortrait = false;

  void config(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenHeight = constraints.maxHeight;
      _screenWidth = constraints.maxWidth;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenHeight = constraints.maxWidth;
      _screenWidth = constraints.maxHeight;
      isPortrait = false;
      isMobilePortrait = false;
    }
    imageSizeMultiplier = heightMultiplier = _screenHeight / designScreenHeight;
    widthMultiplier = textMultiplier = _screenWidth / designScreenWidth;
  }
}
