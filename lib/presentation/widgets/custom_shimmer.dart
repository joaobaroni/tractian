import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// A custom shimmer to show loading effects
class CustomShimmer extends StatelessWidget {
  /// The widget which shimmer will apply loading effects
  final Widget child;

  /// Show loading effects when loading is true, otherwise animates to [child]
  final bool isLoading;

  /// An optional duration of the transition between loading effect and child
  final Duration duration;

  /// An optional [baseColor] for the shimmer effect
  final Color? baseColor;

  /// An optional [highlightColor] for the shimmer effect
  final Color? highlightColor;

  /// An optional circular border radius to create a rounded shimmer area
  final double borderRadius;

  /// Creates a [CustomShimmer]
  const CustomShimmer({
    Key? key,
    required this.child,
    required bool loading,
    this.duration = const Duration(milliseconds: 250),
    this.baseColor,
    this.highlightColor,
    this.borderRadius = 24.0,
  })  : isLoading = loading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade700,
        highlightColor: highlightColor ?? Colors.grey.shade400,
        enabled: isLoading,
        child: child,
      ),
      secondChild: child,
      crossFadeState: isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
      firstCurve: Curves.easeOut,
      secondCurve: Curves.easeIn,
    );
  }
}

/// A widget which wrapper the content to create a shimmer area effect
class CustomShimmerArea extends StatelessWidget {
  /// The widget which will be wrapped
  final Widget child;

  /// If shimmer is enabled
  final bool isLoading;

  /// An optional circular border radius to create a rounded shimmer area.
  ///
  /// Default value is 24.0.
  final double? borderRadius;

  /// Creates a [CustomShimmerArea]
  const CustomShimmerArea({
    Key? key,
    required this.child,
    required bool loading,
    this.borderRadius,
  })  : isLoading = loading,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius ?? 24.0),
            ),
            child: Container(
              foregroundDecoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              child: child,
            ),
          )
        : child;
  }
}
