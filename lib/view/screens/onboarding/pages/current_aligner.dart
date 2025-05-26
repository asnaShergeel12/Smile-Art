import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/my_text_field.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

class CurrentAligner extends StatelessWidget {
  const CurrentAligner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          MyText(text: "About your aligners",size:16,weight:FontWeight.w500,color:kPrimaryColor,),

          MyText(text: "How many days have you been wearing your current aligner?",size:24,weight:FontWeight.w600,color:kTextColor,),
          const SizedBox(height:8,),
          MyTextField(bordercolor:kPrimaryColor,textColor:kPrimaryColor, keyboardType: TextInputType.number,)
        ],),
    );
  }
}
