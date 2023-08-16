import 'package:tractian/data/data.dart';
import 'package:tractian/domain/domain.dart';

/// A utility class responsible for converting JSON data to a WorkOrder object.
abstract class WorkOrderMapper {
  /// Converts a JSON representation into a WorkOrder object.
  static WorkOrder fromJson(Map<String, dynamic> json) {
    return WorkOrder(
      id: json['id'],
      assetId: json['assetId'],
      assignedUserIds: List.from(json['assignedUserIds']),
      status: WorkOrderStatusMapper.fromString(json['status'].toString()),
      priority: WorkOrderPriorityMapper.fromString(json['priority'].toString()),
      checkList: List.from(json['checklist'].map((item) => CheckListItemMapper.fromJson(item))),
      title: json['title'],
      description: json['description'],
    );
  }
}
