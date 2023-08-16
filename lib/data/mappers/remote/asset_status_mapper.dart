import 'package:tractian/domain/domain.dart';

/// A utility class responsible for mapping string values to AssetStatus enum.
abstract class AssetStatusMapper {
  /// Maps a string value to a AssetStatus enum.
  ///
  /// [value] is the string value representing the priority.
  /// Returns the corresponding WorkOrderPriority enum value.
  static AssetStatus fromString(String value) {
    switch (value) {
      case 'inOperation':
        return AssetStatus.inOperation;
      case 'inAlert':
        return AssetStatus.inAlert;
      case 'unplannedStop':
        return AssetStatus.unplannedStop;
      case 'plannedStop':
        return AssetStatus.plannedStop;
      case 'inDowntime':
        return AssetStatus.inDowntime;
    }

    throw ArgumentError('Unable to recognize AssetStatus. $value');
  }
}
