import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';

/// Abstract class representing a repository for asset-related operations.
abstract class IAssetRepository {
  /// Retrieves a list of assets.
  ///
  Future<Either<Failure, List<Asset>>> get({int limit = 12, int offset = 0});

  /// Retrieves an Asset.
  ///
  Future<Either<Failure, Asset>> getById({required int id});
}
