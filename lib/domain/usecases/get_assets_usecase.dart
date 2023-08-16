import 'package:dartz/dartz.dart';
import 'package:tractian/domain/domain.dart';
import 'package:tractian/domain/repositories/asset_repository.dart';

///
/// Abstract class defining the use case for retrieving a list of assets.
///
abstract class IGetAssetsUsecase {
  ///
  /// Retrieves a list of assets.
  ///
  Future<Either<Failure, List<Asset>>> call({int limit = 12, int offset = 0});
}

class GetAssetsUsecase implements IGetAssetsUsecase {
  GetAssetsUsecase(this._repository);
  final IAssetRepository _repository;

  @override
  Future<Either<Failure, List<Asset>>> call({int limit = 12, int offset = 0}) async {
    return _repository.get(limit: limit, offset: offset);
  }
}
