import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

///
/// Abstract class defining the use case for creating a work order.
///
abstract class ICreateWorkOrderUsecase {
  ///
  /// Creates a new work order.
  ///
  Future<Either<Failure, int>> call({required WorkOrderParams params});
}

class CreateWorkOrderUsecase implements ICreateWorkOrderUsecase {
  CreateWorkOrderUsecase(this._repository);
  final IWorkOrderRepository _repository;

  @override
  Future<Either<Failure, int>> call({required WorkOrderParams params}) async {
    return _repository.create(params: params);
  }
}
