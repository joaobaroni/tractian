import 'package:get/get.dart';
import 'package:tractian/domain/usecases/usecases.dart';

import '../../domain/domain.dart';
import '../mvvm/mvvm.dart';

class AssetsViewModel extends ViewModel {
  final assetItems = Rx<List<Asset>>([]);
  final isLoading = Rx<bool>(true);

  AssetsViewModel(this._iGetAssetsUsecase);

  final IGetAssetsUsecase _iGetAssetsUsecase;

  @override
  void onInit() {
    _initialFetch();
    super.onInit();
  }

  void _initialFetch() async {
    final result = await _iGetAssetsUsecase();
    result.fold((l) => null, (r) {
      assetItems.value = r;
      isLoading.value = false;
    });
    update();
  }
}
