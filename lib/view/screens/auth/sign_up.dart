import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_style.dart';
import 'package:smile_art/controller/sign_up_controller.dart';
import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_validators.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import 'login.dart';
import 'otp.dart';

class SignUp extends StatelessWidget {
  final signupController = Get.find<SignUpController>();

  SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Signup"),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Texts(children: [
              const TextSpan(
                  text: "Already have an account?  ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kGreyColor,
                  )),
              TextSpan(
                  text: "Login",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(Login());
                    },
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  )),
            ]),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: signupController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Signup",
                  style: kTextHeading,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text: "Create your account to discover the app effortlessly",
                  color: kGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  label: "Full Name",
                  controller: signupController.nameController,
                  validator: (value) => AppValidators.instance
                      .validateRepeatPassword(value, signupController.nameController.text),

                ),
                MyTextField(
                  label: "Email Address",
                  controller: signupController.emailController,
                  validator: (value)=>AppValidators.instance.validateEmail(signupController.emailController.text),
                ),
                MyTextField(
                  label: "Create Password",
                  controller: signupController.createPasswordController,
                  validator: (value)=>AppValidators.instance.validatePassword(signupController.createPasswordController.text),
                  isObSecure: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonImageView(
                      svgPath: Assets.iconsSecureIcon,
                    ),
                  ),
                ),
                MyTextField(
                  label: "Repeat Password",
                  controller: signupController.repeatPasswordController,
                  validator: (value)=> AppValidators.instance.validateRepeatPassword(
                      signupController.createPasswordController.text,
                      signupController.repeatPasswordController.text),
                  isObSecure: true,
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
                Row(
                  children: [
                    CustomCheckBox(isActive: true, onTap: () {}),
                    const SizedBox(
                      width: 6,
                    ),
                    MyText(
                      text: "I agree to the Terms and Conditions.",
                      size: 11,
                      color: kGreyColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                MyButton(
                    onTap: () async {
                      if (signupController.validateForm()) {
                        String? result = await signupController.signup(); // Wait for result
                        if (result == null) {
                          Get.to(() => OTP()); // Navigate only on success
                        }
                      }
                    },
                    buttonText: "Signup"),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      color: kBorderColor,
                    )),
                    const SizedBox(
                      width: 18,
                    ),
                    MyText(
                      text: "or continue with",
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    const Expanded(
                        child: Divider(
                      color: kBorderColor,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      buttonText: "",
                      onTap: () async {
                        if(Platform.isAndroid || Platform.isIOS){
                          bool isSuccess = await signupController.signInWithGoogle();
                          if(isSuccess){
                            Get.to(() => OTP());
                          }
                        }
                      },
                      customChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/images/google_logo.svg"),
                      ),
                      width: 101,
                      bgColor: kSecondaryColor,
                      borderColor: kBorderColor,
                    ),
                    CustomButton(
                      buttonText: "",
                      onTap: () {},
                      customChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/images/apple_logo.svg"),
                      ),
                      width: 101,
                      bgColor: kSecondaryColor,
                      borderColor: kBorderColor,
                    ),
                    CustomButton(
                      buttonText: "",
                      onTap: () {},
                      customChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:
                            SvgPicture.asset("assets/images/facebook_logo.svg"),
                      ),
                      width: 101,
                      bgColor: kSecondaryColor,
                      borderColor: kBorderColor,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
