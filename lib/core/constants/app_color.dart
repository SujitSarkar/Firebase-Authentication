import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xff24459C);
  static const int primarySwatch = 0xff2196f3;

  static const Color errorColor = Colors.red;
  static const Color enableColor = Colors.green;
  static const Color disableColor = Colors.grey;
  static const Color warningColor = Color.fromARGB(255, 217, 155, 9);

  static const Color appBodyBg = Colors.white;
  static const Color whiteColor = Colors.white;

  static const Color textFieldHintColor = Color(0xff9CA3AF);
  static const Color textFieldIconColor = Color(0xff9CA3AF);
  static const Color textFieldUnderlineColor = Color(0xffEAEAEC);

  static final Color textColor = Colors.grey.shade800;
  static const Color titleTextColor = Color(0xff4D5983);
  static const Color secondaryTextColor = Color(0xff868DAA);

  static const Map<int, Color> primaryColorMap = {
    50: Color.fromRGBO(36, 69, 156, .1),
    100: Color.fromRGBO(36, 69, 156, .2),
    200: Color.fromRGBO(36, 69, 156, .3),
    300: Color.fromRGBO(36, 69, 156, .4),
    400: Color.fromRGBO(36, 69, 156, .5),
    500: Color.fromRGBO(36, 69, 156, .6),
    600: Color.fromRGBO(36, 69, 156, .7),
    700: Color.fromRGBO(36, 69, 156, .8),
    800: Color.fromRGBO(36, 69, 156, .9),
    900: Color.fromRGBO(36, 69, 156, 1)
  };
}
