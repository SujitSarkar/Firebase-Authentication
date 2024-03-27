import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_color.dart';
import 'app_navigator_key.dart';

void showToast(String message, {ToastGravity? position}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: position ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

void showSuccessDialog(String title, String message) => AwesomeDialog(
      context: AppNavigatorKey.key.currentState!.context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: title,
      titleTextStyle: TextStyle(
          color: const Color(0xffE77824),
          fontSize: 20.sp,
          fontWeight: FontWeight.w700),
      descTextStyle: TextStyle(
          color: const Color(0xff6B7280),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700),
      desc: message,
      btnOkColor: AppColor.primaryColor,
      btnOkOnPress: () {},
    btnOkText: 'Okay'
    )..show();

void showErrorDialog(String title, String message) => AwesomeDialog(
      context: AppNavigatorKey.key.currentState!.context,
      dialogType: DialogType.error,
      animType: AnimType.topSlide,
      btnOkColor: AppColor.primaryColor,
      title: title,
      titleTextStyle: TextStyle(
          color: AppColor.errorColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700),
      descTextStyle: TextStyle(
          color: const Color(0xff6B7280),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700),
      desc: message,
      btnOkOnPress: () {},
      btnOkText: 'Okay'
    )..show();
