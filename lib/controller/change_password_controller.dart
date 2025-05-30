import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/auth_service.dart';
import '../view/widgets/custom_snackbar.dart';
import '../view/widgets/log_out_dialogue.dart';

class ChangePasswordController extends GetxController{
   RxBool obscurePass = true.obs;
   RxBool obscureConfirmPass = true.obs;
   final changePassFormKey = GlobalKey<FormState>();
   final passwordController = TextEditingController();
   final confirmPasswordController = TextEditingController();
   AuthService authService = AuthService();

   bool validateForm() {
      return changePassFormKey.currentState?.validate() ?? false;
   }

   void changePassword()async {
      String password = passwordController.text.trim();
      try {
         final result = await authService.changePassword(password);
         if (result != null) {
            CustomSnackbar.success(title: "Success", message: "Your password has been updated successfully!");
            // showLogOutDialog( context:Get.context!);
            passwordController.clear();
            confirmPasswordController.clear();

         }
      } catch (e) {
         CustomSnackbar.error(title: "Error", message: e.toString().replaceAll('Exception: ', ''));
      }
   }

   @override
   void onClose() {
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.onClose();
   }

}