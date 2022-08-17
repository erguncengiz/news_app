import '../../resources/constants.dart';

// ignore: camel_case_extensions
extension xEndPoint on String {
  String addEndPoint() {
    return Constants.api.baseUrl + this;
  }
}

extension xSharedPrefsKeys on SharedPrefsKeys {
  String get rawValue {
    switch (this) {
      case SharedPrefsKeys.likedNews:
        return "likedNews";
      default:
        return "-";
    }
  }
}
