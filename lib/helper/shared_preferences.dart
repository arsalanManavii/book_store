import 'package:book_store_application/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences sharedPreferences;
  static initFunction() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setTheme(bool isDark) {
    sharedPreferences.setBool(Constants.KEYTHEME, isDark);
  }

  static bool get isDarkTheme =>
      sharedPreferences.getBool(Constants.KEYTHEME) ?? false;
}
