import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../auth_service.dart';

class ForgotPasswordController extends GetxController{
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  clearField(){
    emailController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}