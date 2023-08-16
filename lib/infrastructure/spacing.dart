import 'package:flutter/cupertino.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

/// The recommended scaling factor for material is 8
/// See more
/// https://m2.material.io/design/layout/spacing-methods.html#baseline-grid
const int _kDefaultSpacingFactor = 8;

/// Default app spacing, considering responsiveness.
class Spacing {
  /// Extra small = 4
  static const xxs = Spacing(0.5);

  /// Extra small = 8
  static const xs = Spacing(1);

  /// Small = 16
  static const sm = Spacing(2);

  /// Medium = 24
  static const md = Spacing(3);

  /// Large = 32
  static const lg = Spacing(4);

  /// Extra large = 40
  static const xl = Spacing(5);

  /// Extra large = 48
  static const xxl = Spacing(6);

  /// Extra large = 64
  static const xxxl = Spacing(7);

  double get value => _val * factor;

  final double _val;

  /// The scalling factor for gutters and margins
  final int factor;

  const Spacing(this._val, {this.factor = _kDefaultSpacingFactor});

  /// Binary subtration operatior.
  Spacing operator -(Spacing other) => Spacing(value - other.value);

  /// Binary addition operator.
  Spacing operator +(Spacing other) => Spacing(value + other.value);

  /// Multiplication operator.
  Spacing operator *(double operand) => Spacing(value * operand);
}

/// Add extension method to [Spacing] handle responsiveness.
extension SpacingExtensions on Spacing {
  /// Current vlaue with [responsiveWidth] extension.
  double get width => value.responsiveWidth;

  /// Current value with [responsiveHeight] extension.
  double get height => value.responsiveHeight;

  /// Builds a [SizedBox] with vertical spacing using responsiveHeight.
  SizedBox get vertical => SizedBox(height: value.responsiveHeight);

  /// Builds a [SizedBox] with horizontal spacing using responsiveWidth.
  SizedBox get horizontal => SizedBox(width: value.responsiveWidth);
}
