import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smile_art/binding/forgot_password_binding.dart';
import 'package:smile_art/binding/sign_up_binding.dart';
import 'package:smile_art/constant/app_style.dart';
import 'package:smile_art/controller/login_controller.dart';
import 'package:smile_art/utils/app_validators.dart';
import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import '../bottom_bar/bottom_navbar.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class Login extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Login"),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Texts(children: [
              const TextSpan(
                  text: "Don’t have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kGreyColor,
                  )),
              TextSpan(
                  text: "Signup",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(() => SignUp(), binding: SignUpBinding());
                    },
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  )),
            ]),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Form(
            key: loginController.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Login",
                  style: kTextHeading,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text:
                      "Login to your account to discover and buy the best photographs effortlessly.",
                  color: kGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  label: "Email Address",
                  controller: loginController.emailController,
                  validator: (value) => AppValidators.instance
                      .validateEmail(loginController.emailController.text),
                ),
                MyTextField(
                  label: "Password",
                  controller: loginController.passwordController,
                  validator: (value) => AppValidators.instance.validatePassword(
                      loginController.passwordController.text),
                  isObSecure: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CommonImageView(
                      svgPath: Assets.iconsSecureIcon,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyText(
                      text: "Forgot Password?",
                      size: 14,
                      color: kRedColor,
                      onTap: () {
                        loginController.clearFields();
                        Get.to(() => ForgotPassword(),
                            binding: ForgotPasswordBinding());
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Obx(
                      () => CustomCheckBox(
                        isActive: loginController.isChecked.value,
                        onTap: () {
                          loginController.isChecked.value =
                              !loginController.isChecked.value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    MyText(
                      text: "Remember me ",
                      size: 11,
                      color: kGreyColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                MyButton(
                    onTap: () async {
                      if (loginController.validateForm()) {
                        bool isSuccess = await loginController.login();
                        if (isSuccess) {
                          loginController.clearFields();
                          Get.offAll(const CustomBottomNavBar());
                        }
                      }
                    },
                    buttonText: "Login"),
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
                    MyText(text: "or continue with"),
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
                        bool isSuccess =
                            await loginController.logInWithGoogle();
                        if (isSuccess) {
                          Get.to(() => const CustomBottomNavBar());
                        }
                      },
                      customChild: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(Assets.imagesGoogleLogo),
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
                        child: SvgPicture.asset(Assets.imagesAppleLogo),
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
                        child: SvgPicture.asset(Assets.imagesFacebookLogo),
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
