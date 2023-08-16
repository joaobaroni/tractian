import 'package:equatable/equatable.dart';
import 'package:tractian/domain/domain.dart';

/// Class representing a work order.
class WorkOrder extends Equatable {
  /// Creates a new instance of [WorkOrder].
  const WorkOrder({
    required this.id,
    required this.assetId,
    required this.assignedUserIds,
    required this.status,
    required this.priority,
    required this.title,
    this.checkList,
    this.description,
  });

  /// The unique identifier of the work order.
  final int id;

  /// A title describing work order
  final String title;

  /// The unique identifier of the asset associated with the work order.
  final int assetId;

  /// The list of user IDs assigned to the work order.
  final List<int> assignedUserIds;

  /// A description or additional information about the work order.
  final String? description;

  /// The current status of the work order.
  final WorkOrderStatus status;

  /// The priority level of the work order.
  final WorkOrderPriority priority;

  /// The checklist items associated with the work order (if applicable).
  final List<CheckListItem>? checkList;

  /// Creates a copy of this [WorkOrder] with specified attributes replaced.
  WorkOrder copyWith({
    int? id,
    int? assetId,
    List<int>? assignedUserIds,
    String? description,
    WorkOrderStatus? status,
    WorkOrderPriority? priority,
    List<CheckListItem>? checkList,
    String? title,
  }) {
    return WorkOrder(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      assignedUserIds: assignedUserIds ?? this.assignedUserIds,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      checkList: checkList ?? this.checkList,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [id, assetId, assignedUserIds, description, status, priority, checkList, title];
}
