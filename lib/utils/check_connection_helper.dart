import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckConnectionHelper {
  static Future<bool> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
