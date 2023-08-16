import 'package:dartz/dartz.dart';
import 'package:tractian/domain/repositories/repositories.dart';

import '../domain.dart';

///
/// Abstract class defining the use case for searching work orders by title.
///
abstract class ISearchWorkOrderByTitleUsecase {
  /// Searches for work orders based on their titles.
  Future<Either<Failure, List<WorkOrder>>> call({required String title, int limit = 12, int offset = 0});
}

class SearchWorkOrderByTitleUsecase implements ISearchWorkOrderByTitleUsecase {
  SearchWorkOrderByTitleUsecase(this._repository);
  final IWorkOrderRepository _repository;

  @override
  Future<Either<Failure, List<WorkOrder>>> call({required String title, int limit = 12, int offset = 0}) async {
    return _repository.searchByTitle(title: title, limit: limit, offset: offset);
  }
}
