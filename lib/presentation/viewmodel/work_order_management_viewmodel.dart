import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tractian/domain/usecases/create_checklist_item_usecase.dart';
import 'package:tractian/presentation/mvvm/mvvm.dart';

import '../../domain/domain.dart';

abstract class WorkOrderManagementViewModel extends ViewModel {
  WorkOrderManagementViewModel(this._iGetAssetsUsecase, this._iGetUsersUsecase);

  final IGetUsersUsecase _iGetUsersUsecase;
  final IGetAssetsUsecase _iGetAssetsUsecase;

  final Rx<List<User>?> availableUsers = Rx(null);
  final Rx<List<Asset>?> availableAssets = Rx(null);
  final Rx<List<CheckListItem>> checkListItems = Rx([]);
  final List<User> selectedUsers = [];
  final Rx<WorkOrderPriority> priority = Rx(WorkOrderPriority.low);
  Asset? selectedAsset;

  @mustCallSuper
  @override
  void onInit() {
    Future.wait([
      _checkAvailableUsers(),
      _checkAvailableAssets(),
    ]).then((_) => onOptionsLoad());
    super.onInit();
  }

  Future<void> _checkAvailableUsers() async {
    final result = await _iGetUsersUsecase();
    result.fold((l) => null, (r) => availableUsers.value = r);
    update();
  }

  Future<void> _checkAvailableAssets() async {
    final result = await _iGetAssetsUsecase();
    result.fold((l) => null, (r) => availableAssets.value = r);
    update();
  }

  void updatePriority(WorkOrderPriority priority) {
    this.priority.value = priority;
    update();
  }

  void addCheckListItem() {
    checkListItems.value.add(const CheckListItem(title: '', isCompleted: false, id: -1));
    update();
  }

  Future<void> saveWorkOrder({required String title, String? description});

  void onOptionsLoad();

  void updateSelectedUsers(User user, bool isSelected) {
    if (isSelected) {
      selectedUsers.add(user);
    } else {
      selectedUsers.remove(user);
    }
    update();
  }
}

class WorkOrderCreationViewModel extends WorkOrderManagementViewModel {
  WorkOrderCreationViewModel(
    this._iCreateChecklistItemUsecase,
    this._iCreateWorkOrderUsecase,
    IGetUsersUsecase iGetUsersUsecase,
    IGetAssetsUsecase iGetAssetsUsecase,
  ) : super(iGetAssetsUsecase, iGetUsersUsecase);

  final ICreateWorkOrderUsecase _iCreateWorkOrderUsecase;
  final ICreateChecklistItemUsecase _iCreateChecklistItemUsecase;

  @override
  void onOptionsLoad() {
    // TODO: implement onOptionsLoad
  }

  @override
  Future<void> saveWorkOrder({required String title, String? description}) async {
    final result = await _iCreateWorkOrderUsecase(
      params: WorkOrderParams(
        assetId: selectedAsset!.id,
        assignedUserIds: selectedUsers.map((e) => e.id).toList(),
        priority: priority.value,
        title: title,
        description: description,
      ),
    );

    if (result.isRight()) {
      final id = result.fold((l) => null, (r) => r);
      for (final items in checkListItems.value) {
        await _iCreateChecklistItemUsecase(isCompleted: items.isCompleted, title: items.title, workOrderId: id!);
      }
    }
  }
}

class WorkOrderEditingViewModel extends WorkOrderManagementViewModel {
  WorkOrderEditingViewModel(
    this._iUpdateCheckListItemUsecase,
    this._iUpdateWorkOrderUsecase,
    IGetUsersUsecase iGetUsersUsecase,
    IGetAssetsUsecase iGetAssetsUsecase,
  ) : super(iGetAssetsUsecase, iGetUsersUsecase);

  final IUpdateCheckListItemUsecase _iUpdateCheckListItemUsecase;
  final IUpdateWorkOrderUsecase _iUpdateWorkOrderUsecase;

  WorkOrderParams? initialParams;
  int? workOrderId;

  void initialize({required WorkOrderParams params, required int id}) {
    initialParams = params;
    workOrderId = id;
    priority.value = params.priority;
    if (params.checkList != null) checkListItems.value.addAll(params.checkList!);
  }

  @override
  void onOptionsLoad() {
    selectedAsset = availableAssets.value!.firstWhere((element) => element.id == initialParams!.assetId);
    selectedUsers.addAll(availableUsers.value!.where((element) => initialParams!.assignedUserIds.contains(element.id)));
  }

  @override
  Future<void> saveWorkOrder({required String title, String? description}) async {
    final result = await _iUpdateWorkOrderUsecase(
      id: workOrderId!,
      params: WorkOrderParams(
        assetId: selectedAsset!.id,
        assignedUserIds: selectedUsers.map((e) => e.id).toList(),
        priority: priority.value,
        title: title,
        checkList: checkListItems.value,
        description: description,
      ),
    );
  }
}
