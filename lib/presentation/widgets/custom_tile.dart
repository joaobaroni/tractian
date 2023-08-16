import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tractian/presentation/presentation.dart';
import 'package:tractian/presentation/widgets/custom_shimmer.dart';

import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

/// An abstract class `CustomTile` is a reusable widget designed to display customized tiles with various content types.
abstract class CustomTile extends StatelessWidget {
  /// A callback function to execute when the tile is tapped.
  final VoidCallback onTap;

  /// Constructs a `CustomTile`.
  const CustomTile({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  /// Creates a `CustomTile` specialized for displaying asset-related content.
  const factory CustomTile.asset({
    required Asset asset,
    required VoidCallback onTap,
    Key? key,
  }) = _AssetTile;

  /// Creates a `CustomTile` specialized for displaying work order-related content.
  const factory CustomTile.workOrder({
    required WorkOrder workOrder,
    required VoidCallback onTap,
    Key? key,
  }) = _WorkOrderTile;

  /// Retrieves the widget to be displayed as the leading element in the tile.
  Widget leading(BuildContext context);

  /// Retrieves the title of the tile.
  String get title;

  /// Retrieves the widget to be displayed as the subtitle in the tile.
  Widget subtitle(BuildContext context);

  /// Retrieves a tuple containing color and status string for a status indicator.
  (Color, String) status(BuildContext context);

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    final statusDetail = status(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.screenWidth,
        padding: EdgeInsets.only(
          left: Spacing.sm.width,
          right: Spacing.xs.width,
          top: Spacing.sm.height,
          bottom: Spacing.sm.height,
        ),
        child: Row(
          children: [
            leading(context),
            Spacing.sm.horizontal,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.fontSize,
                  ),
                ),
                subtitle(context),
                SizedBox(height: 5.responsiveHeight),
                RoundedTag(label: Text(statusDetail.$2), backgroundColor: statusDetail.$1)
              ],
            ),
            const Spacer(),
            const Icon(AppIcons.arrow)
          ],
        ),
      ),
    );
  }
}

class _AssetTile extends CustomTile {
  const _AssetTile({required this.asset, required super.onTap, super.key});
  final Asset asset;

  @override
  Widget leading(BuildContext context) {
    return CustomCachedNetworkImage(
      imageUrl: asset.image,
      width: 80.responsiveWidth,
      height: 80.responsiveHeight,
      placeholder: (context, url) {
        return CustomShimmerArea(
          loading: true,
          child: SizedBox(width: 80.responsiveWidth, height: 80.responsiveHeight),
        );
      },
    );
  }

  @override
  (Color, String) status(BuildContext context) => (asset.status.color, asset.status.label);

  @override
  Widget subtitle(BuildContext context) {
    return Row(
      children: [
        Icon(AppIcons.location, size: 16.fontSize, color: context.colorPalette.primary),
        Text(
          'Injection / Painting',
          style: TextStyle(fontSize: 14.fontSize, fontWeight: FontWeight.w500, color: const Color(0xFF8C959F)),
        ),
      ],
    );
  }

  @override
  String get title => asset.name;
}

class _WorkOrderTile extends CustomTile {
  const _WorkOrderTile({
    required this.workOrder,
    required super.onTap,
    super.key,
  });

  final WorkOrder workOrder;

  @override
  Widget leading(BuildContext context) {
    return Icon(
      AppIcons.workOrderLarge,
      color: const Color(0xFF93C5FD),
      size: 44.fontSize,
    );
  }

  @override
  (Color, String) status(BuildContext context) => (workOrder.status.color, workOrder.status.label);

  @override
  Widget subtitle(BuildContext context) {
    return Text(
      'Work Order ID #${workOrder.id}',
      style: TextStyle(fontSize: 14.fontSize, fontWeight: FontWeight.w500, color: const Color(0xFF8C959F)),
    );
  }

  @override
  String get title => workOrder.title;
}
