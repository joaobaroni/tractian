import 'package:tractian/domain/domain.dart';

/// A utility class responsible for mapping string values to WorkOrderStatus enum.
abstract class WorkOrderStatusMapper {
  /// Maps a string value to a WorkOrderStatus enum.
  ///
  /// [value] is the string value representing the status.
  /// Returns the corresponding WorkOrderStatus enum value.
  static WorkOrderStatus fromString(String value) {
    switch (value) {
      case 'open':
        return WorkOrderStatus.open;
      case 'in progress':
        return WorkOrderStatus.inProgress;
      case 'done':
      case 'completed':
        return WorkOrderStatus.done;
    }
    throw ArgumentError('Unable to recognize WorkOrderStatus. $value');
  }
}
