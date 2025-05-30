import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/change_password_controller.dart';

import '../../../generated/assets.dart';
import '../../../utils/app_validators.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/log_out_dialogue.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/profile_appbar.dart';

class ChangePassword extends StatelessWidget {
  final changePasswordController = Get.find<ChangePasswordController>();

  ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar("Change Password"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyButton(
            onTap: () {
              if (changePasswordController.validateForm()) {
                changePasswordController.changePassword();
              } else {
                CustomSnackbar.error(title: "Unknown error occurred", message: "Please try again later");
              }
            },
            buttonText: "Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: changePasswordController.changePassFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 38,
              ),
              MyTextField(
                label: 'Password',
                controller: changePasswordController.passwordController,
                validator: (value) => AppValidators.instance.validatePassword(value),
                isObSecure: changePasswordController.obscurePass.value,
                suffixTap: () => changePasswordController.obscurePass.toggle(),
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
                controller: changePasswordController.confirmPasswordController,
                validator: (value) => AppValidators.instance
                    .validateRepeatPassword(
                        changePasswordController.passwordController.text, value),
                isObSecure: changePasswordController.obscureConfirmPass.value,
                suffixTap: () =>
                    changePasswordController.obscureConfirmPass.toggle(),
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
    );
  }
}
