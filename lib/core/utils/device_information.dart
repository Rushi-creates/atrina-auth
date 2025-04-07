

import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';


class DeviceInformation {

  /// Get Platform Name
  String getDevicePlatform() {
    String platformType = "";
    platformType = Platform.isAndroid ? "android" : "ios";
    return platformType;
  }


  /// Get App Version Data
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  // /// Get App Build Number Data
  // Future<int> getAppBuildNumber() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   return int.parse(packageInfo.buildNumber);
  // }

  /// Get App Package Name
  Future<String> getAppPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
}