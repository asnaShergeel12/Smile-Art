import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController{
  final newPasswordController  = TextEditingController();
  final confirmPasswordController  = TextEditingController();
  final resetPassFormKey = GlobalKey<FormState>();

  bool validateForm() {
    return resetPassFormKey.currentState?.validate() ?? false;
  }

  clearFields(){
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

}