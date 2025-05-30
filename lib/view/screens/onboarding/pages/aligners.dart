import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/my_text_field.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../../controller/onboarding_controller.dart';

class Aligners extends StatelessWidget {
  final onboardingController = Get.find<OnboardingController>();
  Aligners({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          MyText(text: "About your aligners",size:16,weight:FontWeight.w500,color:kPrimaryColor,),

          MyText(text: "${onboardingController.user.firstName} how many aligners do you have?",size:24,weight:FontWeight.w600,color:kTextColor,),
          const SizedBox(height:8,),
          MyTextField(
            controller: onboardingController.totalAlignerNumberController,
            bordercolor:kPrimaryColor,
            textColor:kPrimaryColor,
            keyboardType: TextInputType.number,
          )
        ],),
    );
  }
}
