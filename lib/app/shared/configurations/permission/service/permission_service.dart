import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final Set<Permission> _ungrantedOnes = <Permission>{};

  static Future<bool> isRequiredGranted() async {
    final requiredPermissions = [
      Permission.location,
    ];

    for (final permission in requiredPermissions) {
      var status = await _checkPermissionStatus(permission);
      if (status != PermissionStatus.granted) {
        _ungrantedOnes.add(permission);
      }
    }
    return _ungrantedOnes.isEmpty;
  }

  static Future<void> requestMultiple() async {
    for (final permission in _ungrantedOnes) {
      PermissionStatus status = await permission.status;
      if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
      await permission.request();
    }
    _ungrantedOnes.clear();
  }
}

Future<PermissionStatus> _checkPermissionStatus(Permission permission) async {
  final status = await permission.status;
  return status;
}
