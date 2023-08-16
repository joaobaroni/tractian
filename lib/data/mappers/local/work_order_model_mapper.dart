import 'package:tractian/domain/domain.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

abstract class WorkOrderModelMapper {
  static WorkOrder toEntity(WorkOrderModel model) {
    return WorkOrder(
      id: model.id,
      assetId: model.assetId,
      assignedUserIds: model.assignedUserIds ?? [],
      status: model.status,
      priority: model.priority,
      title: model.title,
      description: model.description,
    );
  }
}
