import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';
import 'app_string.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor, brightness: Brightness.light),
      useMaterial3: true,
      // primarySwatch:
      //     const MaterialColor(AppColor.primarySwatch, AppColor.primaryColorMap),
      fontFamily: AppString.fontName,
      textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: AppString.fontName),
          displayMedium: TextStyle(fontFamily: AppString.fontName),
          displaySmall: TextStyle(fontFamily: AppString.fontName),
          headlineMedium: TextStyle(fontFamily: AppString.fontName),
          headlineSmall: TextStyle(fontFamily: AppString.fontName),
          titleLarge: TextStyle(fontFamily: AppString.fontName),
          titleMedium: TextStyle(fontFamily: AppString.fontName),
          titleSmall: TextStyle(fontFamily: AppString.fontName),
          bodyLarge: TextStyle(fontFamily: AppString.fontName),
          bodyMedium: TextStyle(fontFamily: AppString.fontName),
          bodySmall: TextStyle(fontFamily: AppString.fontName),
          labelLarge: TextStyle(fontFamily: AppString.fontName),
          labelSmall: TextStyle(fontFamily: AppString.fontName)),
      scaffoldBackgroundColor: AppColor.appBodyBg,
      navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: AppColor.primaryColor,
          elevation: 0.0,
          indicatorColor: AppColor.primaryColor),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          titleTextStyle:
              TextStyle(color: AppColor.textColor, fontWeight: FontWeight.bold),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          )),
      canvasColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionColor: AppColor.primaryColor.withOpacity(0.4)),
      bottomSheetTheme:
          const BottomSheetThemeData(modalBackgroundColor: Colors.transparent));


  static var statusBarDesign = SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: AppColor.primaryColor.withOpacity(0.8),
          statusBarIconBrightness: Brightness.light));

  static var hideStatusBar =
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  static var showStatusBar = SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}
