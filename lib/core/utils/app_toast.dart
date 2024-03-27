import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth_app/core/router/page_navigator.dart';
import 'package:flutter/Material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {ToastGravity? position}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: position ?? ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);

void showSuccessDialog(BuildContext context, String message) => AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Success',
      desc: message,
      btnCancelOnPress: () => popScreen(),
      btnOkOnPress: () => popScreen(),
    )..show();

void showErrorDialog(BuildContext context, String message) => AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: message,
      btnCancelOnPress: () => popScreen(),
      btnOkOnPress: () => popScreen(),
    )..show();
