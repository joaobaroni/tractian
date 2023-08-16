import 'package:dartz/dartz.dart';
import 'package:tractian/domain/repositories/repositories.dart';

import '../domain.dart';

///
/// Abstract class defining the use case for retrieving a user by their unique identifier.
///
abstract class IGetUserByIdUsecase {
  ///
  /// Retrieves a user by their unique identifier.
  ///
  Future<Either<Failure, User>> call({required int id});
}

class GetUserByIdUsecase implements IGetUserByIdUsecase {
  GetUserByIdUsecase(this._repository);
  final IUserRepository _repository;

  @override
  Future<Either<Failure, User>> call({required int id}) async {
    return _repository.getById(id: id);
  }
}
