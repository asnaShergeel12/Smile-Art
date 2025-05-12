import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../auth_service.dart';
import '../constant/app_colors.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isCheck = false.obs;
  final AuthService _authService = AuthService();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }


  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      final result = await _authService.login(email, password);

      if (result == null) {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: kSuccessColor,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Success",
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
            messageText: Text(
              "Login successfully!",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        );
        return true; // Indicate success
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: kRedColor,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              "Login Failed",
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
            messageText: Text(
              "Reason: $result",
              style: const TextStyle(color: kSecondaryColor),
            ),
          ),
        );
        return false; // Indicate failure
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: kRedColor,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Error",
            style:
            TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            "Something went wrong. Please try again later.",
            style: TextStyle(color: kSecondaryColor),
          ),
        ),
      );
      return false; // Indicate failure
    }
  }
}
