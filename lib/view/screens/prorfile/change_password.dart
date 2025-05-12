
import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';

import '../../../generated/assets.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/profile_appbar.dart';


class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:profileAppbar("Change Password"),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(16.0),
        child: MyButton(onTap: (){}, buttonText: "Update"),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
          SizedBox(height:38,),
          MyTextField(label: 'Password',isObSecure:true,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonImageView(svgPath:Assets.iconsSecureIcon,),
            ),
          ),
          SizedBox(height:8,),
          MyTextField(label: 'Confirm Password',isObSecure:true,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonImageView(svgPath:Assets.iconsSecureIcon,),
            ),
          ),
          SizedBox(height:8,),
          MyText(text: ". Minimum 8 Characters ",color:kGreyColor,),
          MyText(text: ". 1 Uppercase  ",color:kGreyColor,),
          MyText(text: ". 1 Lowercase  ",color:kGreyColor,),
          MyText(text: ". 1 Number  ",color:kGreyColor,),
          MyText(text: ". 1 Special Character  ",color:kGreyColor,),
        ],),
      ),
    );
  }
}
