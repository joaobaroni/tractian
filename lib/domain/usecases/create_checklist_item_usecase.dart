import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class ICreateChecklistItemUsecase {
  Future<Either<Failure, int>> call({required String title, required bool isCompleted, required int workOrderId});
}

class CreateCheckListItemUsecase implements ICreateChecklistItemUsecase {
  CreateCheckListItemUsecase(this._repository);
  final ICheckListRepository _repository;

  @override
  Future<Either<Failure, int>> call(
      {required String title, required bool isCompleted, required int workOrderId}) async {
    return await _repository.create(title: title, isCompleted: isCompleted, workOrderId: workOrderId);
  }
}
