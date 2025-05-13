import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import '../auth_service.dart';
import '../constant/app_colors.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isCheck = false.obs;
  final AuthService _authService = AuthService();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      final result = await _authService.login(email, password);

      if (result == null) {
        CustomSnackbar.success(
          title: "Success",
          message: "Login successfully!",
        );
        return true;
      } else {
        CustomSnackbar.error(
            title: "Login Failed",
            message: result,
        );
        return false; // Indicate failure
      }
    } catch (e) {
      CustomSnackbar.error(
          title: "Error",
          message: "Something went wrong. Please try again later.");
      return false; // Indicate failure
    }
  }
}
