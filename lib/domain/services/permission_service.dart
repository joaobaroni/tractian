import '../domain.dart';

///
/// Use case to handle device permissions.
///
abstract class IPermissionService {
  ///
  /// Check and, if necessary, request a [permission] access to user.
  /// Returns [true] if permission is granted, otherwise returns [false].
  /// Can throw [AppPermissionException] for alternative cases.
  ///
  Future<bool> request(AppPermission permission);

  /// Open app settings. Throws an [AppPermissionException] when fails.
  Future<bool> openSettings();

  /// Check permission status for an [appPermission]

  Future<AppPermissionStatus> checkStatus(AppPermission appPermission);
}

class PermissionService implements IPermissionService {
  PermissionService(this._repository);
  
  final PermissionRepository _repository;

  @override
  Future<AppPermissionStatus> checkStatus(AppPermission appPermission) {
    return _repository.check(appPermission);
  }

  @override
  Future<bool> openSettings() {
    return _repository.openSettings();
  }

  @override
  Future<bool> request(AppPermission permission) async {
    return (await _repository.request(permission)) == AppPermissionStatus.granted;
  }
}
