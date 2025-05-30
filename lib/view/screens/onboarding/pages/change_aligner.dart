import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/my_text_field.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../../controller/onboarding_controller.dart';

class ChangeAligner extends StatelessWidget {
  final onboardingController = Get.find<OnboardingController>();
  ChangeAligner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          MyText(text: "About your aligners",size:16,weight:FontWeight.w500,color:kPrimaryColor,),

          MyText(text: "What is the best time to remind you to change your aligner?",size:24,weight:FontWeight.w600,color:kTextColor,),
          const SizedBox(height:8,),
          MyTextField(
            controller: onboardingController.reminderController, readOnly: true, showCursor: false,
            bordercolor:kPrimaryColor,textColor:kPrimaryColor,
            suffixIcon: const Icon(Icons.calendar_today, color: kGreyColor),
              suffixTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                      child: child!,
                    );
                  },
                );

                if (pickedTime != null) {
                  // Combine today's date with selected time
                  final now = DateTime.now();
                  final selectedDateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  // Show formatted string in the text field
                  final formatted = DateFormat('hh:mm a').format(selectedDateTime);
                  onboardingController.reminderController.text = formatted;

                  onboardingController.selectedReminderTime = selectedDateTime;
                }
              }

          )
        ],),
    );
  }
}
