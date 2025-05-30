import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/app_colors.dart';
import '../../../controller/otp_controller.dart';
import '../../widgets/auth_appbar.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_pin_code.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/rich_texts.dart';
import 'login.dart';

class OTP extends StatelessWidget {
  OTP({super.key});
  final otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    // final String email;
    return Scaffold(
      appBar: authAppBar("Account Verification"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  text: "Enter OTP sent to your email to verify your account.",
                  color: kGreyColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyPinCode(
                  controller: otpController.pinController,
                  onChanged: (value) => otpController.enteredOtp.value = value,
                  onCompleted: (pin) {},
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => GestureDetector(
                    child: Texts(children: [
                      TextSpan(
                          text: otpController.resendCooldown.value > 0
                              ? '00:${otpController.resendCooldown.value.toString().padLeft(2, '0')}'
                              : '00:00 ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kGreyColor,
                          )),
                      TextSpan(
                          text: otpController.resendCooldown.value > 0
                              ? ''
                              : " Resend",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryColor,
                          )),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                MyButton(
                    onTap: () => otpController.verifyOtp(),
                    buttonText: "Confirm"),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
