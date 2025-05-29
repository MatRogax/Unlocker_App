import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projeto_unloucker/app/utils/constants.dart';

class Utils {
  static String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? "http://172.18.144.1:3000";

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

  static Dio get dioIstance {
    final options = BaseOptions(baseUrl: apiBaseUrl);
    return Dio(options);
  }
}
