import 'package:dartz/dartz.dart';

import '../domain.dart';

///
/// Abstract class defining the use case for updating a checklist item.
///
abstract class IUpdateCheckListItemUsecase {
  ///
  /// Updates a checklist item.
  ///
  Future<Either<Failure, Unit>> call({required CheckListItem item, required int workOrderId});
}

class UpdateCheckListItemUsecase implements IUpdateCheckListItemUsecase {
  UpdateCheckListItemUsecase(this._repository);
  final ICheckListRepository _repository;

  @override
  Future<Either<Failure, Unit>> call({required CheckListItem item, required int workOrderId}) async {
    return _repository.update(item: item);
  }
}
