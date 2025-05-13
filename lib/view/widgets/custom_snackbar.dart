import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';

class CustomSnackbar {
  static void success({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: kSuccessColor,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          title,
          style: const TextStyle(
              color: kSecondaryColor, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: const TextStyle(color: kSecondaryColor),
        ),
      ),
    );
  }

  static void error({required String title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: kRedColor,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          title,
          style: const TextStyle(
              color: kSecondaryColor, fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: const TextStyle(color: kSecondaryColor),
        ),
      ),
    );
  }
}
