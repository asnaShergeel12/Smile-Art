import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smile_art/constant/app_style.dart';

import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import 'login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Forgot Password"),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 18,
                ),
               Text("Reset Your Password",style:kTextHeading,),
                SizedBox(
                  height: 10,
                ),
                MyText(
                  text:
                  "Forgot your password? No worries! Enter your email below to receive a reset lnk.",
                  color: kGreyColor,
                ),
                SizedBox(
                  height: 18,
                ),
                MyTextField(label: "Email Address"),



                  ],
                ),
            Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: Column(
                children: [
                  MyButton(onTap: () {
                    showCustomDialog(context: context,image:Assets.imagesCheckMail,
                        title:"Check Your Email",
                        confirmText:"Back to Login",
                        subtitle:"Password reset link has been sent on your email address.", onTap: () {  Get.to(Login()); }
                    );
                  }, buttonText: "Send Password Reset Link"),
                  SizedBox(height:14,),
                  Texts(children: [
                    TextSpan(
                        text: "Remember your password?  ",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kGreyColor,
                        )),
                    TextSpan(
                        text: "Login",
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Get.to(Login());
                        },
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,)),
                  ]),
                  SizedBox(height:14,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}