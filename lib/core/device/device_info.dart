import 'package:device_info_plus/device_info_plus.dart';

abstract class DeviceInfo {
  Future<String> get deviceId;
}

class DeviceInfoImpl implements DeviceInfo {
  final DeviceInfoPlugin deviceInfoPlugin;

  const DeviceInfoImpl({
    required this.deviceInfoPlugin,
  });

  @override
  Future<String> get deviceId async {
    final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.display;
  }
}
