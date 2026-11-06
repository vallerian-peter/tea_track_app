import 'package:package_info_plus/package_info_plus.dart';

/// App name, package and version read from the platform via package_info_plus.
///
/// Call [load] once in main(); the synchronous getters are empty until then.
abstract final class AppInfo {
  static PackageInfo? _info;

  static Future<PackageInfo> load() async {
    return _info ??= await PackageInfo.fromPlatform();
  }

  static String get appName => _info?.appName ?? '';

  static String get packageName => _info?.packageName ?? '';

  /// e.g. `1.0.0`
  static String get version => _info?.version ?? '';

  /// e.g. `1`
  static String get buildNumber => _info?.buildNumber ?? '';

  /// e.g. `1.0.0+1`, matching `version:` in pubspec.yaml.
  static String get fullVersion {
    if (version.isEmpty) return '';
    return buildNumber.isEmpty ? version : '$version+$buildNumber';
  }
}
