import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  ///  The decoration to paint behind the [child].
  final CustomCachedNetworkImageDecoration decoration;

  /// Widgets width
  final double? width;

  /// Widget's height
  final double? height;

  /// The target image that is displayed.
  final String imageUrl;

  /// The target image's cache key.
  final String? cacheKey;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget? child;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The clip behavior when [Container.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  final Clip clipBehavior;

  /// When set to true it will animate from the old image to the new image
  /// if the url changes.
  final bool useOldImageOnUrlChange;

  const CustomCachedNetworkImage({
    super.key,
    this.width,
    this.height,
    this.decoration = const CustomCachedNetworkImageDecoration(),
    required this.imageUrl,
    this.clipBehavior = Clip.none,
    this.child,
    this.cacheKey,
    this.errorWidget,
    this.margin,
    this.padding,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.useOldImageOnUrlChange = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      cacheKey: cacheKey,
      placeholder: placeholder,
      errorWidget: errorWidget,
      progressIndicatorBuilder: progressIndicatorBuilder,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          margin: margin,
          padding: padding,
          clipBehavior: clipBehavior,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: decoration.border,
            color: decoration.color,
            boxShadow: decoration.boxShadow,
            gradient: decoration.gradient,
            shape: decoration.shape,
            backgroundBlendMode: decoration.backgroundBlendMode,
            image: DecorationImage(
              image: imageProvider,
              fit: decoration.fit,
              opacity: decoration.opacity,
              scale: decoration.scale,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

class CustomCachedNetworkImageDecoration {
  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not [BoxShape.rectangle].
  /// The [shape] or the [borderRadius] won't clip the children of the decorated [Container]. If the clip is required, insert a clip widget (e.g., [ClipRect], [ClipRRect], [ClipPath]) as the child of the [Container]. Be aware that clipping may be costly in terms of performance.
  final BorderRadiusGeometry? borderRadius;

  /// A border to draw above the background [color], [gradient], or [image].
  /// Follows the [shape] and [borderRadius].
  /// Use [Border] objects to describe borders that do not depend on the reading direction.
  /// Use [BoxBorder] objects to describe borders that should flip their left and right edges based on whether the text is being read left-to-right or right-to-left.
  final BoxBorder? border;

  /// The color to fill in the background of the box.
  /// The color is filled into the [shape] of the box (e.g., either a rectangle, potentially with a [borderRadius], or a circle).
  /// This is ignored if [gradient] is non-null.
  /// The [color] is drawn under the [image].
  final Color? color;

  /// A list of shadows cast by this box behind the box.
  /// The shadow follows the [shape] of the box.
  ///
  /// See also:
  /// [kElevationToShadow], for some predefined shadows used in Material Design.
  /// [PhysicalModel], a widget for showing shadows.
  final List<BoxShadow>? boxShadow;

  /// A gradient to use when filling the box.
  /// If this is specified, [color] has no effect.
  /// The [gradient] is drawn under the [image].
  final Gradient? gradient;

  /// The shape to fill the background [color], [gradient], and [image] into and to cast as the [boxShadow].
  /// If this is [BoxShape.circle] then [borderRadius] is ignored.
  /// The [shape] cannot be interpolated; animating between two [BoxDecoration]s with different [shape]s will result in a discontinuity in the rendering. To interpolate between two shapes, consider using [ShapeDecoration] and different [ShapeBorder]s; in particular, [CircleBorder] instead of [BoxShape.circle] and [RoundedRectangleBorder] instead of [BoxShape.rectangle].
  /// The [shape] or the [borderRadius] won't clip the children of the decorated [Container]. If the clip is required, insert a clip widget (e.g., [ClipRect], [ClipRRect], [ClipPath]) as the child of the [Container]. Be aware that clipping may be costly in terms of performance.
  final BoxShape shape;

  /// The blend mode applied to the [color] or [gradient] background of the box.
  /// If no [backgroundBlendMode] is provided then the default painting blend mode is used.
  /// If no [color] or [gradient] is provided then the blend mode has no impact.
  final BlendMode? backgroundBlendMode;

  /// How the image should be inscribed into the box.
  ///
  /// The default is [BoxFit.scaleDown] if [centerSlice] is null, and
  /// [BoxFit.fill] if [centerSlice] is not null.
  ///
  /// See the discussion at [paintImage] for more details.
  final BoxFit fit;

  /// A color filter to apply to the image before painting it.
  final ColorFilter? colorFilter;

  /// Defines image pixels to be shown per logical pixels.
  ///
  /// By default the value of scale is 1.0. The scale for the image is
  /// calculated by multiplying [scale] with `scale` of the given [ImageProvider].
  final double scale;

  /// If non-null, the value is multiplied with the opacity of each image
  /// pixel before painting onto the canvas.
  ///
  /// This is more efficient than using [Opacity] or [FadeTransition] to
  /// change the opacity of an image.
  final double opacity;

  const CustomCachedNetworkImageDecoration({
    this.backgroundBlendMode,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.color,
    this.colorFilter,
    this.fit = BoxFit.fill,
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.scale = 1.0,
    this.opacity = 1.0,
  });
}
