import 'package:tractian/data/data.dart';
import 'package:tractian/domain/domain.dart';

abstract class IAssetRemoteDataSource {
  Future<List<Asset>> get({int limit = 12, int offset = 0});
  Future<Asset> getById({required int id});
}

class AssetRemoteDataSource implements IAssetRemoteDataSource {
  AssetRemoteDataSource(this.client);
  final IHttpClient client;

  @override
  Future<List<Asset>> get({int limit = 12, int offset = 0}) async {
    final result = await client.get('assets');
    if (result.status != HttpStatus.ok) throw GenericHttpException(result.status.code);
    return List.from(result.data.map((item) => AssetMapper.fromJson(item)));
  }

  @override
  Future<Asset> getById({required int id}) async {
    final result = await client.get('assets/$id');
    if (result.status != HttpStatus.ok) throw GenericHttpException(result.status.code);
    return AssetMapper.fromJson(result.data);
  }
}
