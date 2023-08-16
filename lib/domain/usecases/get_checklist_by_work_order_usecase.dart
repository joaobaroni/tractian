import 'package:dartz/dartz.dart';

import '../domain.dart';

///
/// Abstract class defining the use case for retrieving a list of assets.
///
abstract class IGetChecklistByWorkOrderUsecase {
  ///
  /// Retrieves a list of assets.
  ///
  Future<Either<Failure, List<CheckListItem>>> call({required int workOrderId});
}

class GetChecklistByWorkOrderUsecase implements IGetChecklistByWorkOrderUsecase {
  GetChecklistByWorkOrderUsecase(this._repository);

  final ICheckListRepository _repository;

  @override
  Future<Either<Failure, List<CheckListItem>>> call({required int workOrderId}) async {
    return _repository.getByWorkOrder(workOrderId: workOrderId);
  }
}
