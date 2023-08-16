import 'package:equatable/equatable.dart';
import 'package:tractian/domain/domain.dart';

/// Class representing an asset.
class Asset extends Equatable {
  /// Creates a new instance of [Asset].
  const Asset({
    required this.id,
    required this.name,
    required this.healthScore,
    required this.model,
    required this.sensors,
    required this.image,
    required this.status,
    required this.statusHistory,
  });

  /// The unique identifier of the asset.
  final int id;

  /// The name of the asset.
  final String name;

  /// The health score of the asset.
  final double healthScore;

  /// The model of the asset.
  final String model;

  /// The list of sensors associated with the asset.
  final List<String> sensors;

  /// The image representation of the asset.
  final String image;

  /// The current status of the asset.
  final AssetStatus status;

  /// The history of status changes for the asset.
  final List<AssetStatusDataPoint> statusHistory;

  /// Creates a copy of this [Asset] with specified attributes replaced.
  Asset copyWith({
    int? id,
    String? name,
    double? healthScore,
    String? model,
    List<String>? sensors,
    String? image,
    AssetStatus? status,
    List<AssetStatusDataPoint>? statusHistory,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      healthScore: healthScore ?? this.healthScore,
      model: model ?? this.model,
      sensors: sensors ?? this.sensors,
      image: image ?? this.image,
      status: status ?? this.status,
      statusHistory: statusHistory ?? this.statusHistory,
    );
  }

  @override
  List<Object?> get props => [id, name, healthScore, model, sensors, image, status, statusHistory];
}
