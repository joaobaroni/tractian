import 'package:tractian/domain/domain.dart';

/// A utility class responsible for mapping string values to WorkOrderPriority enum.
abstract class WorkOrderPriorityMapper {
  /// Maps a string value to a WorkOrderPriority enum.
  ///
  /// [value] is the string value representing the priority.
  /// Returns the corresponding WorkOrderPriority enum value.
  static WorkOrderPriority fromString(String value) {
    switch (value) {
      case 'high':
        return WorkOrderPriority.high;
      case 'medium':
        return WorkOrderPriority.medium;
      case 'low':
        return WorkOrderPriority.low;
    }

    throw ArgumentError('Unable to recognize WorkOrderStatus. $value');
  }
}
