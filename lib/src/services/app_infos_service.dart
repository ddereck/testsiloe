import 'package:package_info_plus/package_info_plus.dart';

class AppInfosService {
  
  static PackageInfo? packageInfo;
  static Future<void> init() async{
    packageInfo = await PackageInfo.fromPlatform();
  }

  static String get appName => packageInfo!.appName;
  static String get packageName => packageInfo!.packageName;
  static String get version => packageInfo!.version;
  static String get buildNumber => packageInfo!.buildNumber;

  static String get appVersion => "$version+$buildNumber";

  static String get appVersionWithAppName => "$appName $appVersion";

  static String get appVersionWithAppNameAndPackageName => "$appVersionWithAppName ($packageName)";

  static String get appVersionWithPackageName => "$appVersion ($packageName)";

  static String get appNameWithPackageName => "$appName ($packageName)";

  static String get appAuthor => "Nigel ADOVI";
}