import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/binding/login_binding.dart';
import 'package:smile_art/binding/sign_up_binding.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:smile_art/view/screens/auth/sign_up.dart';
import 'package:smile_art/view/screens/onboarding/onboarding.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';
import '../../../generated/assets.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          kPrimaryColor,
          kPrimaryColor,
          kPrimaryColor,
          kPrimaryColor,
          kSecondaryColor.withOpacity(0.99)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0,vertical:38),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                CommonImageView(
                  height: 64,
                  imagePath: Assets.imagesWhiteLogo,
                ),
               Column(children: [
                 CommonImageView(
                   imagePath: Assets.imagesTeeth,
                 ),
                 MyText(
                   text: "Lorem ipsum dolor",
                   color: kSecondaryColor,
                   size: 30,
                   weight: FontWeight.w700,
                 ),
                 MyText(
                   textAlign: TextAlign.center,
                   text:
                   "Lorem ipsum dolor sit amet, consectet adipis elit. Nunc vulputate libero ",
                   color: kSecondaryColor,
                   size: 16,
                   lineHeight: 1.5,
                   weight: FontWeight.w400,
                 ),
               ],),
                Column(
                  children: [
                    MyButton(
                      onTap: () {
                        Get.to(()=>Login(), binding: LoginBinding());
                      },
                      buttonText: "Login",
                      backgroundColor: kSecondaryColor,
                      fontColor: kPrimaryColor,
                    ),
                    const SizedBox(height:18,),
                    MyButton(
                      onTap: () {
                        Get.to(()=> SignUp(),binding: SignUpBinding());
                      },
                      buttonText: "Sign Up",
                      fontColor: kSecondaryColor,
                      backgroundColor: Colors.transparent,
                      outlineColor: kSecondaryColor,
                    ),
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
