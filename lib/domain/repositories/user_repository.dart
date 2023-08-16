import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

/// Abstract class representing a repository for user-related operations.
abstract class IUserRepository {
  /// Retrieves a list of users.
  ///
  Future<Either<Failure, List<User>>> get({int limit = 12, int offset = 0});

  /// Retrieves a user by their unique identifier.
  ///
  Future<Either<Failure, User>> getById({required int id});
}
