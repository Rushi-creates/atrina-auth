
import 'package:auth_app1/core/network/baseurls.dart';

enum Flavor { dev, qa, stage, prod }

class FlavorConfig {

  final Flavor flavor;
  final String name;
  final String customerBaseUrl;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor? flavor}) {
    _instance ??= FlavorConfig._internal(
      flavor!,
      getValue(flavor),
      getBaseUrl(flavor),
    );
    return _instance!;
  }

  FlavorConfig._internal(
      this.flavor,
      this.name,
      this.customerBaseUrl,
      );


  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isDev() => _instance!.flavor == Flavor.dev;

  static bool isQa() => _instance!.flavor == Flavor.qa;

  static bool isStage() => _instance!.flavor == Flavor.stage;

  static bool isProd() => _instance!.flavor == Flavor.prod;

  static String getValue(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return "DEV";
      case Flavor.qa:
        return "QA";
      case Flavor.stage:
        return "STAGE";
      case Flavor.prod:
        return "PROD";
      default:
        return "";
    }
  }

  static String getBaseUrl(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        return BaseUrls.baseUrlDev;
      case Flavor.qa:
        return BaseUrls.baseUrlQA;
      case Flavor.stage:
        return BaseUrls.baseUrlStage;
      case Flavor.prod:
        return BaseUrls.baseUrlProd;
      default:
        return BaseUrls.baseUrlDev;
    }
  }
}
