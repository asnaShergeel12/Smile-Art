import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/auth_service.dart';
import 'package:smile_art/binding/login_binding.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/reset_password_controller.dart';
import 'package:smile_art/utils/app_validators.dart';
import '../../../generated/assets.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import 'login.dart';

class ResetPassword extends StatelessWidget {
  final resetPassController = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Change Password"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyButton(
            onTap: () async {
              if (resetPassController.validateForm()) {
                String newPassword = resetPassController.newPasswordController.text.trim();
                bool isUpdated = await AuthService().updateNewForgottenPassword(newPassword);
                print("New Password: $newPassword");
                resetPassController.clearFields();
                if (isUpdated) {
                  Get.offAll(() => Login(), binding: LoginBinding());
                }
              }
            },
            buttonText: "Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: resetPassController.resetPassFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 38,
                ),
                MyTextField(
                  label: 'Password',
                  controller: resetPassController.newPasswordController,
                  isObSecure: true,
                  validator: (value) =>
                      AppValidators.instance.validatePassword(value),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonImageView(
                      svgPath: Assets.iconsSecureIcon,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyTextField(
                  label: 'Confirm Password',
                  isObSecure: true,
                  controller: resetPassController.confirmPasswordController,
                  validator: (value) => AppValidators.instance
                      .validateRepeatPassword(resetPassController.confirmPasswordController.text,
                          resetPassController.newPasswordController.text),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonImageView(
                      svgPath: Assets.iconsSecureIcon,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyText(
                  text: ". Minimum 8 Characters ",
                  color: kGreyColor,
                ),
                MyText(
                  text: ". 1 Uppercase  ",
                  color: kGreyColor,
                ),
                MyText(
                  text: ". 1 Lowercase  ",
                  color: kGreyColor,
                ),
                MyText(
                  text: ". 1 Number  ",
                  color: kGreyColor,
                ),
                MyText(
                  text: ". 1 Special Character  ",
                  color: kGreyColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
