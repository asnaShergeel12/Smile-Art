import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/auth_service.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';

class SignUpController extends GetxController {
  final RxBool isPasswordVisible = true.obs;
  final signupFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final createPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  RxBool isChecked = false.obs;
  final AuthService _authService = AuthService();


  bool validateForm() {
    return signupFormKey.currentState?.validate() ?? false;
  }

  // Future<String?> signup() async {
  //   String email = emailController.text.trim();
  //   String password = createPasswordController.text.trim();
  //   String fullname = nameController.text.trim();
  //
  //   try {
  //     final result = await _authService.signup(email, password, fullname);
  //
  //     if (result == null) {
  //       CustomSnackbar.success(
  //         title: "Success",
  //         message: "Account created successfully!",
  //       );
  //     } else {
  //       CustomSnackbar.error(
  //           title: "Signup Failed",
  //           message: result,
  //       );
  //     }
  //   } catch (e) {
  //     CustomSnackbar.error(
  //         title: "Error",
  //         message: "Something went wrong. Please try again later.",
  //     );
  //   }
  //   return null;
  // }

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

  clearFields(){
    nameController.clear();
    emailController.clear();
    createPasswordController.clear();
    repeatPasswordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    createPasswordController.dispose();
    repeatPasswordController.dispose();
    super.onClose();
  }
}
