// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class Utils {
  static String apiKey = "2e271329609241c49c78fa1f0c203155";

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

  // static Dio get dioIstance {
  //   final options = BaseOptions(baseUrl: apiBaseUrl);
  //   return Dio(options);
  // }

  static void showSuccess({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.green.shade700, icon: Icons.check_circle_outline);
  }

  static void showError({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.red.shade800, icon: Icons.error_outline);
  }

  static void showInfo({required BuildContext context, required String message}) {
    _showSnackbar(context: context, message: message, backgroundColor: Colors.blue.shade700, icon: Icons.info_outline);
  }

  static void _showSnackbar({required BuildContext context, required String message, required Color backgroundColor, required IconData icon}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12.0),
          Expanded(child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15))),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
