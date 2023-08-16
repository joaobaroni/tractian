import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tractian/infrastructure/infrastructure.dart';
import 'package:tractian/presentation/presentation.dart';

import '../../domain/domain.dart';

class AssetDetail extends StatefulWidget {
  const AssetDetail({super.key, required this.asset});

  final Asset asset;

  @override
  State<AssetDetail> createState() => _AssetDetailState();
}

class _AssetDetailState extends State<AssetDetail> {
  List<DateTime> dates = [];

  @override
  void initState() {
    super.initState();
    dates = widget.asset.statusHistory.map((e) => e.date).toList();
    dates.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorPalette.primary,
        iconTheme: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
        title: Text(
          widget.asset.name,
          style: context.textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.sm.width, vertical: Spacing.sm.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1920 / 1080,
                  child: CustomCachedNetworkImage(
                    imageUrl: widget.asset.image,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Spacing.sm.width),
                  child: Text(
                    widget.asset.name,
                    style: TextStyle(fontSize: 20.fontSize, fontWeight: FontWeight.bold),
                  ),
                ),
                _informationRow(
                  context,
                  leading: Icon(
                    AppIcons.status,
                    color: context.colorPalette.primary,
                    size: 24.fontSize,
                  ),
                  title: 'Status',
                  value: RoundedTag(label: Text(widget.asset.status.label), backgroundColor: widget.asset.status.color),
                ),
                _informationRow(
                  context,
                  leading: Icon(
                    AppIcons.sensor,
                    color: context.colorPalette.primary,
                    size: 21.fontSize,
                  ),
                  title: 'Sensor',
                  value: Text(widget.asset.sensors.join(',')),
                ),
                _informationRow(
                  context,
                  leading: Icon(
                    AppIcons.cube,
                    color: context.colorPalette.primary,
                    size: 24.fontSize,
                  ),
                  title: 'Model',
                  value: Text(widget.asset.model),
                ),
                _informationRow(
                  context,
                  leading: Icon(
                    AppIcons.openOrders,
                    color: context.colorPalette.error,
                    size: 20.fontSize,
                  ),
                  title: 'Open Orders',
                  value: Text('2'),
                ),
                _informationRow(
                  context,
                  leading: Icon(
                    AppIcons.health,
                    color: context.colorPalette.primary,
                    size: 24.fontSize,
                  ),
                  title: 'Health Score',
                  value: Text(widget.asset.healthScore.toString()),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7.responsiveHeight),
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(interval: 1.0, maximum: 5),
                    series: <LineSeries>[
                      LineSeries<AssetStatusDataPoint, DateTime>(
                        dataSource: widget.asset.statusHistory,
                        xValueMapper: (datum, index) => datum.date,
                        yValueMapper: (datum, index) => datum.status.index,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _informationRow(
    BuildContext context, {
    required String title,
    required Widget leading,
    required Widget value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.responsiveHeight),
      child: Column(
        children: [
          Row(children: [
            leading,
            Spacing.xs.horizontal,
            Text(
              title,
              style: TextStyle(
                fontSize: 16.fontSize,
                color: const Color(0xFF24292F),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            DefaultTextStyle(
              style: TextStyle(fontSize: 16.fontSize, color: const Color(0xFF57606A), fontWeight: FontWeight.w400),
              child: value,
            )
          ]),
          SizedBox(height: 12.responsiveHeight),
          Divider(
            color: context.colorPalette.primary.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
