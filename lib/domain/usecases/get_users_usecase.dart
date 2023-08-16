import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

import '../repositories/repositories.dart';

///
/// Abstract class defining the use case for retrieving a list of users.
///
abstract class IGetUsersUsecase {
  ///
  /// Retrieves a list of users.
  ///
  Future<Either<Failure, List<User>>> call({int limit = 12, int offset = 0});
}

class GetUsersUsecase implements IGetUsersUsecase {
  GetUsersUsecase(this._repository);

  final IUserRepository _repository;

  @override
  Future<Either<Failure, List<User>>> call({int limit = 12, int offset = 0}) async {
    return _repository.get(limit: limit, offset: offset);
  }
}
