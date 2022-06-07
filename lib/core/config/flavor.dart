import 'package:hivet/core/config/common_constant.dart';

enum ParamsFlavor {
  URL,
  NAME,
  FLAVOR,
}

class FlavorConfigs {
  final String env;

  const FlavorConfigs({required this.env}) : super();

  String getter(
    String env,
    dynamic param,
  ) {
    String returner = CommonConstants.baseUrlDev;

    switch (env) {
      case 'Prod':
        switch (param) {
          case ParamsFlavor.URL:
            returner = CommonConstants.baseUrlProd;
            break;
          case ParamsFlavor.NAME:
            returner = 'Hivet Prod';
            break;
          default:
        }
        break;
      case 'Qa':
        switch (param) {
          case 'url':
            returner = CommonConstants.baseUrlQA;
            break;
          case 'name':
            returner = 'Hivet QA';
            break;
          default:
        }
        break;
      case 'Dev':
        switch (param) {
          case 'url':
            returner = CommonConstants.baseUrlDev;
            break;
          case 'name':
            returner = 'Hivet Dev';
            break;
          default:
        }
        break;

      default:
    }
    return returner;
  }

  String getUrl() {
    return getter(env, ParamsFlavor.URL);
  }

  String getName() {
    return getter(env, ParamsFlavor.NAME);
  }

  String getFlavor() {
    return env;
  }
}
