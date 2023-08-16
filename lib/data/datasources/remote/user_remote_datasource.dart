import 'package:tractian/data/data.dart';
import 'package:tractian/domain/domain.dart';

abstract class IUserRemoteDatasource {
  Future<List<User>> get({required int limit, required int offset});
  Future<User> getById({required int id});
}

class UserRemoteDatasource implements IUserRemoteDatasource {
  UserRemoteDatasource(this._client);

  final IHttpClient _client;

  @override
  Future<List<User>> get({required int limit, required int offset}) async {
    final result = await _client.get('users');
    if (result.status != HttpStatus.ok) throw GenericHttpException(result.status.code);
    return List.from(result.data.map((item) => UserMapper.fromJson(item)));
  }

  @override
  Future<User> getById({required int id}) async {
    final result = await _client.get('users/$id');
    if (result.status != HttpStatus.ok) throw GenericHttpException(result.status.code);
    return UserMapper.fromJson(result.data);
  }
}
