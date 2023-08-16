import 'package:get/get.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/domain/usecases/get_checklist_by_work_order_usecase.dart';
import 'package:tractian/domain/usecases/usecases.dart';

import '../mvvm/mvvm.dart';

class WorkOrderDetailViewModel extends ViewModel {
  WorkOrderDetailViewModel(
    this._iGetUserByIdUsecase,
    this._iUpdateCheckListItemUsecase,
    this._iUpdateWorkOrderStatusUsecase,
    this._iGetAssetByIdUsecase,
    this._iGetChecklistByWorkOrderUsecase,
  );

  late final Rx<WorkOrder> workOrder;
  final Rx<List<User>?> assignedUsers = Rx(null);
  final Rx<Asset?> assetDetails = Rx(null);
  final Rx<bool> isLoading = Rx(true);

  final IGetUserByIdUsecase _iGetUserByIdUsecase;
  final IUpdateCheckListItemUsecase _iUpdateCheckListItemUsecase;
  final IUpdateWorkOrderStatusUsecase _iUpdateWorkOrderStatusUsecase;
  final IGetAssetByIdUsecase _iGetAssetByIdUsecase;
  final IGetChecklistByWorkOrderUsecase _iGetChecklistByWorkOrderUsecase;

  void initialize(WorkOrder order) {
    workOrder = Rx<WorkOrder>(order);
    Future.wait([_checkAllAssignees(), _checkAsset(), _checkCheckList()]);
  }

  void updateStatus(WorkOrderStatus status) async {
    if (status == workOrder.value.status) return;
    final result = await _iUpdateWorkOrderStatusUsecase(id: workOrder.value.id, newStatus: status);
    if (result.isRight()) {
      workOrder.value = workOrder.value.copyWith(status: status);
      update();
    }
  }

  Future<void> _checkAllAssignees() async {
    final bool hasAssignee = workOrder.value.assignedUserIds.isNotEmpty;
    if (!hasAssignee) return;

    final List<User> users = [];
    for (var userId in workOrder.value.assignedUserIds) {
      final result = await _iGetUserByIdUsecase(id: userId);
      result.fold((l) => null, (r) => users.add(r));
    }

    assignedUsers.value = users;
    update();
  }

  Future<void> _checkAsset() async {
    final result = await _iGetAssetByIdUsecase(id: workOrder.value.assetId);
    result.fold((l) => null, (r) => assetDetails.value = r);
  }

  Future<void> _checkCheckList() async {
    final result = await _iGetChecklistByWorkOrderUsecase(workOrderId: workOrder.value.id);
    result.fold((l) => workOrder.value = workOrder.value.copyWith(checkList: []),
        (r) => workOrder.value = workOrder.value.copyWith(checkList: r));
    update();
  }

  void updateCheckListItemStatus(CheckListItem item, int index) async {
    final result = await _iUpdateCheckListItemUsecase(item: item, workOrderId: workOrder.value.id);
    if (result.isRight()) {
      workOrder.value.checkList![index] = item;
      update();
    }
  }
}
