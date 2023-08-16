import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/domain/repositories/repositories.dart';

///
/// Abstract class defining the use case for retrieving a list of work orders.
///
abstract class IGetWorkOrdersUsecase {
  ///
  /// Retrieves a list of work orders.
  ///
  Future<Either<Failure, List<WorkOrder>>> call({int limit = 12, int offset = 0});
}

class GetWorkOrdersUsecase implements IGetWorkOrdersUsecase {
  GetWorkOrdersUsecase(this._repository);
  final IWorkOrderRepository _repository;

  @override
  Future<Either<Failure, List<WorkOrder>>> call({int limit = 12, int offset = 0}) async {
    return _repository.get(limit: limit, offset: offset);
  }
}
