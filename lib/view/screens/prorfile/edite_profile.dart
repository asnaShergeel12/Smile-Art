import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/controller/edit_profile_controller.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/profile_appbar.dart';
import '../../widgets/profile_pic.dart';

class EditeProfile extends StatelessWidget {
  final editProfileController = Get.find<EditProfileController>();
  EditeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:profileAppbar("Edit profile"),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap:true,
                children: [
                const SizedBox(height:28,),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePic(),
                    const SizedBox(height:8,),
                    MyText(text: editProfileController.user.firstName,),
                    MyText(text: editProfileController.user.email,),
                  ],
                ),
                const SizedBox(height:28,),
                MyTextField(label: 'Full Name', controller: editProfileController.fullNameController, textCapitalization: TextCapitalization.words,),
                const SizedBox(height:8,),
                MyTextField(label: 'Email Address', controller: editProfileController.emailController, readOnly: true, showCursor: false,),

              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: MyButton(
                onTap: () async {
                  await editProfileController.updateUserProfile();
                },
                buttonText: "Update",
              ),
            ),
              ],
        ),
      ),
    );
  }
}
