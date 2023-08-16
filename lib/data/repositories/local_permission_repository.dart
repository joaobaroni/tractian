import 'package:tractian/domain/domain.dart';

class LocalPermissionRepository implements PermissionRepository {
  LocalPermissionRepository(this._client);

  final DevicePermissionClient _client;

  @override
  Future<AppPermissionStatus> check(AppPermission appPermission) async {
    return _client.checkStatus(appPermission);
  }

  @override
  Future<bool> openSettings() {
    return _client.openSettings();
  }

  @override
  Future<AppPermissionStatus> request(AppPermission appPermission) {
    return _client.request(appPermission);
  }
}
