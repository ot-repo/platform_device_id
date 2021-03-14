import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:platform_device_id_platform_interface/platform_device_id_platform_interface.dart';

/// Provides device id information.
class PlatformDeviceId {

  /// Provides device and operating system information.
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  /// Information derived from `android`-`androidId` or `ios`-`identifierForVendor`
  static Future<String?> get getDeviceId async {
    String? deviceId;
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      } else {
        deviceId = await PlatformDeviceIdPlatform.instance.getDeviceId();
      }
    } on PlatformException {
      deviceId = '';
    }
    return deviceId;
  }
}
