import 'package:tractian/domain/domain.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

///
/// ***IMPORTANT
///
/// Unfortunately, this is the part of the code that leaves me most dissatisfied.
/// Ideally, we wouldn't have any Companions here.
/// Due to the limited time, we'll stick with it, unfortunately.
///
abstract class ILocalDatabase {
  Future<List<WorkOrderModel>> queryWorkOrders({int limit = 12, int offset = 0, String? title});
  Future<int> addWorkOrder(WorkOrderCompanion companion);
  Future<void> addMultiplesWorkOrders(List<WorkOrderCompanion> companions);
  Future<void> updateWorkOrderDetails({required int id, WorkOrderParams? params, WorkOrderStatus? status});
  Stream<List<WorkOrderModel>> watchWorkOrders({int limit = 12, int offset = 0, String? title});
  Future<List<CheckListItemModel>> queryCheckListItems({required int workOrderId, int limit = 12, int offset = 0});
  Future<int> addCheckListItem(CheckListItemCompanion companion);
  Future<void> addMultiplesCheckListItems(List<CheckListItemCompanion> companions);
  Future<void> updateCheckListItem({required int id, required bool completed});
}
