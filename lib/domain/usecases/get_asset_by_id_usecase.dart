import 'package:dartz/dartz.dart';
import 'package:tractian/domain/repositories/asset_repository.dart';

import '../domain.dart';

///
/// Abstract class defining the use case for retrieving a list of assets.
///
abstract class IGetAssetByIdUsecase {
  ///
  /// Retrieves a list of assets.
  ///
  Future<Either<Failure, Asset>> call({required int id});
}

class GetAssetByIdUsecase implements IGetAssetByIdUsecase {
  GetAssetByIdUsecase(this._repository);

  final IAssetRepository _repository;

  @override
  Future<Either<Failure, Asset>> call({required int id}) async {
    return _repository.getById(id: id);
  }
}
