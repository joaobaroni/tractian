import 'package:dartz/dartz.dart';
import 'package:tractian/data/data.dart';
import 'package:tractian/domain/entities/user.dart';
import 'package:tractian/domain/repositories/repositories.dart';
import 'package:tractian/domain/validations/failures/failure.dart';

class UserRepository implements IUserRepository {
  UserRepository(this._datasource);
  final IUserRemoteDatasource _datasource;

  @override
  Future<Either<Failure, List<User>>> get({int limit = 12, int offset = 0}) async {
    try {
      final result = await _datasource.get(limit: limit, offset: offset);
      return Right(result);
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, User>> getById({required int id}) async {
    try {
      final result = await _datasource.getById(id: id);
      return Right(result);
    } catch (_) {
      return Left(Failure());
    }
  }
}
