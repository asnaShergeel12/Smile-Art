
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/binding/login_binding.dart';
import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_pin_code.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import 'login.dart';

class OTP extends StatelessWidget {
  OTP({super.key});

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: authAppBar("Account Verification"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 18,
                ),
                MyText(
                  text: "OTP Verification",
                  size: 32,
                  weight: FontWeight.w700,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyText(
                  text:
                  "Enter OTP sent to your email to verify your account.",
                  color: kGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyPinCode(onChanged: (String ) {

                }, onCompleted: (String ) {  },),


              ],
            ),
            Column(
              mainAxisSize:MainAxisSize.min,
              children: [
                Texts(children: const [
                  TextSpan(
                      text: "00:30 ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: kGreyColor,
                         )),
                  TextSpan(
                      text: "Resend",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                          )),
                ]),
                const SizedBox(height:16,),
                MyButton(onTap: () {
                 showCustomDialog(context: context, onTap: (){
                   Get.to(()=>Login(), binding: LoginBinding());
                 },
                   title:"Verification Complete!",
                   subtitle:"Your account has been successfully verified.",
                   image:Assets.imagesVerified,
                   confirmText:"Continue"

                 );
                }, buttonText: "Confirm"),
                const SizedBox(height:16,)

              ],
            ),
          ],
        ),
      ),
    );
  }
}
