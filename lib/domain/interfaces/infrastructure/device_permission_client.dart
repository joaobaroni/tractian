import 'package:tractian/domain/domain.dart';

///
/// Device permission handler
///
abstract class DevicePermissionClient {
  ///
  /// Check status of [permission].
  ///
  Future<AppPermissionStatus> checkStatus(AppPermission permission);

  ///
  /// Request for user to allow access to [permission].
  ///
  Future<AppPermissionStatus> request(AppPermission permission);

  ///
  /// Open app settings
  ///
  Future<bool> openSettings();
}
