import 'package:permission_handler/permission_handler.dart';
import 'package:tractian/domain/domain.dart';

///
/// AppPermissionAdapter
///
class AppPermissionsAdapter implements DevicePermissionClient {
  @override
  Future<AppPermissionStatus> checkStatus(AppPermission permission) async {
    return _convertPermissionStatus(await _getPermission(permission).status);
  }

  @override
  Future<bool> openSettings() async {
    return openAppSettings();
  }

  @override
  Future<AppPermissionStatus> request(AppPermission permission) async {
    final permissionRequest = _getPermission(permission);
    final request = await permissionRequest.request();
    return _convertPermissionStatus(request);
  }

  Permission _getPermission(AppPermission permission) {
    switch (permission) {
      case AppPermission.camera:
        return Permission.camera;
    }
  }

  AppPermissionStatus _convertPermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        return AppPermissionStatus.granted;
      case PermissionStatus.permanentlyDenied:
        return AppPermissionStatus.permanentlyDenied;
      default:
        return AppPermissionStatus.denied;
    }
  }
}
