import 'package:equatable/equatable.dart';
import 'package:tractian/domain/domain.dart';

/// Class representing a data point for asset status at a specific date.
class AssetStatusDataPoint extends Equatable {
  /// Creates a new instance of [AssetStatusDataPoint].
  const AssetStatusDataPoint({
    required this.status,
    required this.date,
  });

  /// The status of the asset at the specific data point.
  final AssetStatus status;

  /// The date associated with the asset status data point.
  final DateTime date;

  @override
  List<Object?> get props => [status, date];
}
