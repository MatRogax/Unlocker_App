import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class Utils {
  static void showToast({required BuildContext context, required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Constants.primaryLight,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
