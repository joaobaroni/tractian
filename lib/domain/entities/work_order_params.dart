import 'package:equatable/equatable.dart';
import 'package:tractian/domain/domain.dart';

/// Class representing parameters for creating a work order.
class WorkOrderParams extends Equatable {
  /// Creates a new instance of [WorkOrderParams].
  const WorkOrderParams({
    required this.assetId,
    required this.assignedUserIds,
    required this.priority,
    required this.title,
    this.description,
    this.checkList,
  });

  /// The unique identifier of the asset associated with the work order.
  final int assetId;

  final String title;

  /// The list of user IDs assigned to the work order.
  final List<int> assignedUserIds;

  /// A description or additional information about the work order.
  final String? description;

  /// The priority level of the work order.
  final WorkOrderPriority priority;

  final List<CheckListItem>? checkList;

  /// Creates a copy of this [WorkOrderParams] with specified attributes replaced.
  WorkOrderParams copyWith({
    int? assetId,
    List<int>? assignedUserIds,
    String? description,
    WorkOrderPriority? priority,
    String? title,
    List<CheckListItem>? checkList,
  }) {
    return WorkOrderParams(
      assetId: assetId ?? this.assetId,
      assignedUserIds: assignedUserIds ?? this.assignedUserIds,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      title: title ?? this.title,
      checkList: checkList ?? this.checkList,
    );
  }

  @override
  List<Object?> get props => [assetId, assignedUserIds, description, priority, checkList];
}
