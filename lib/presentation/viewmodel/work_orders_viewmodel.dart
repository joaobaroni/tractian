import 'dart:async';

import 'package:get/get.dart';
import 'package:tractian/bindings/app_bindings.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/presentation/mvvm/viewmodel.dart';

class WorkOrdersViewModel extends ViewModel {
  final workOrdersItems = Rx<List<WorkOrder>>([]);
  final isLoading = Rx<bool>(true);

  WorkOrdersViewModel(this._iGetWorkOrdersUsecase, this._iSearchWorkOrderByTitleUsecase);

  final IGetWorkOrdersUsecase _iGetWorkOrdersUsecase;
  final ISearchWorkOrderByTitleUsecase _iSearchWorkOrderByTitleUsecase;

  Timer? _debounce;

  @override
  void onInit() {
    _initialFetch();
    super.onInit();
  }

  void _initialFetch() async {
    final result = await _iGetWorkOrdersUsecase();
    result.fold((l) => null, (r) {
      workOrdersItems.value = r;
      isLoading.value = false;
    });
    update();
  }

  void searchOrderByTitle({required String query}) async {
    void performSearch() async {
      isLoading.value = true;
      update();
      final result = await _iSearchWorkOrderByTitleUsecase(title: query);
      result.fold((l) => null, (r) {
        isLoading.value = false;
        workOrdersItems.value = r;
      });
      update();
    }

    const Duration duration = Duration(milliseconds: 400);
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(duration, () => performSearch());
  }
}
