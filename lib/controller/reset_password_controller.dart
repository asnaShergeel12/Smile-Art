import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController{
  final newPasswordController  = TextEditingController();
  final confirmPasswordController  = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
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