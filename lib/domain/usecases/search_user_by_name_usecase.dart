import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

///
/// Abstract class defining the use case for searching users by name.
///
abstract class ISearchUserByNameUsecase {
  ///
  /// Searches for users by name.
  ///
  Future<Either<Failure, List<User>>> call({
    required String name,
    int limit = 12,
    int offset = 0,
  });
}
