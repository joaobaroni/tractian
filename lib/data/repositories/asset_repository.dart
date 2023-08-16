import 'package:dartz/dartz.dart';
import 'package:tractian/data/datasources/remote/asset_remote_datasource.dart';
import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/domain/repositories/asset_repository.dart';
import 'package:tractian/domain/validations/failures/failure.dart';

class AssetRepository implements IAssetRepository {
  const AssetRepository(this._remoteDataSource);

  final IAssetRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Asset>>> get({int limit = 12, int offset = 0}) async {
    try {
      final result = await _remoteDataSource.get(limit: limit, offset: offset);
      return Right(result);
    } catch (_) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Asset>> getById({required int id}) async {
    try {
      final result = await _remoteDataSource.getById(id: id);
      return Right(result);
    } catch (_) {
      return Left(Failure());
    }
  }
}
