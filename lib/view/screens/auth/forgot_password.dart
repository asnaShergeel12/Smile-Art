import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_style.dart';
import 'package:smile_art/controller/forgot_password_controller.dart';
import 'package:smile_art/utils/app_validators.dart';
import '../../../binding/login_binding.dart';
import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import 'login.dart';

class ForgotPassword extends StatelessWidget {
  final forgotPassController = Get.find<ForgotPasswordController>();

  ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Forgot Password"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: forgotPassController.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Reset Your Password",
                    style: kTextHeading,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    text:
                        "Forgot your password? No worries! Enter your email below to receive a reset lnk.",
                    color: kGreyColor,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  MyTextField(
                    label: "Email Address",
                    controller: forgotPassController.emailController,
                    validator: (value) =>
                        AppValidators.instance.validateEmail(value),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Column(
                  children: [
                    MyButton(
                        onTap: () async {
                          if (forgotPassController.validateForm()) {
                            await forgotPassController.authService
                                .resetPasswordViaEmailLink(forgotPassController
                                    .emailController.text
                                    .trim());
                            forgotPassController.clearField();
                            showCustomDialog(
                                context: context,
                                image: Assets.imagesCheckMail,
                                title: "Check Your Email",
                                confirmText: "Back to Login",
                                subtitle:
                                    "Password reset link has been sent on your email address.",
                                onTap: () {
                                  Get.to(()=>Login(), binding: LoginBinding());
                                });
                          }
                        },
                        buttonText: "Send Password Reset Link"),
                    const SizedBox(
                      height: 14,
                    ),
                    Texts(children: [
                      const TextSpan(
                          text: "Remember your password?  ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kGreyColor,
                          )),
                      TextSpan(
                          text: "Login",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(()=>Login(), binding: LoginBinding());
                            },
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          )),
                    ]),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
