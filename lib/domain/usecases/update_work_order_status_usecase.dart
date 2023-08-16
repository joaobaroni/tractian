import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/domain/repositories/repositories.dart';

///
/// Abstract class for updating work order status.
///
abstract class IUpdateWorkOrderStatusUsecase {
  ///
  /// Updates the status of a work order.
  ///
  Future<Either<Failure, Unit>> call({required WorkOrderStatus newStatus, required int id});
}

class UpdateWorkOrderStatusUsecase implements IUpdateWorkOrderStatusUsecase {
  UpdateWorkOrderStatusUsecase(this._repository);

  final IWorkOrderRepository _repository;

  @override
  Future<Either<Failure, Unit>> call({required WorkOrderStatus newStatus, required int id}) async {
    return _repository.update(id: id, status: newStatus);
  }
}
