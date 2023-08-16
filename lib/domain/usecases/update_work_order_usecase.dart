import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

///
/// Abstract class defining the use case for updating a work order.
///
abstract class IUpdateWorkOrderUsecase {
  ///
  /// Updates a work order.
  ///
  Future<Either<Failure, Unit>> call({required WorkOrderParams params, required int id, WorkOrderStatus? status});
}

class UpdateWorkOrderUsecase implements IUpdateWorkOrderUsecase {
  UpdateWorkOrderUsecase(this._repository);

  final IWorkOrderRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(
      {required WorkOrderParams params, required int id, WorkOrderStatus? status}) async {
    return _repository.update(id: id, params: params, status: status);
  }
}
