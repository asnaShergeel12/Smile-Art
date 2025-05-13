import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/auth_service.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constant/app_colors.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final createPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  RxBool isCheck = false.obs;
  final AuthService _authService = AuthService();


  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<String?> signup() async {
    String email = emailController.text.trim();
    String password = createPasswordController.text.trim();

    try {
      final result = await _authService.signup(email, password);

      if (result == null) {
        Get.showSnackbar(
          const GetSnackBar(
            backgroundColor: kSuccessColor,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              "Success",
              style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
            messageText: Text(
              "Account created successfully!",
              style: TextStyle(color: kSecondaryColor),
            ),
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            backgroundColor: kRedColor,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.BOTTOM,
            titleText: const Text(
              "Signup Failed",
              style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
            messageText: Text(
              "Reason: $result",
              style: const TextStyle(color: kSecondaryColor),
            ),
          ),
        );
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          backgroundColor: kRedColor,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Error",
            style: TextStyle(color:kSecondaryColor, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            "Something went wrong. Please try again later.",
            style: TextStyle(color: kSecondaryColor),
          ),
        ),
      );
    }
    return null;
  }

  Future<bool> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
      CustomSnackbar.success(
        title: "Success",
        message: "Signed in with Google successfully!",
      );
      return true;
    } catch (e) {
      CustomSnackbar.error(
          title:"Google Sign-In Failed",
          message: "Error: ${e.toString()}",
      );
      return false;
    }
  }

}
