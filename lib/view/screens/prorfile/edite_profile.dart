
import 'package:flutter/material.dart';

import '../../widgets/log_out_dialogue.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/profile_appbar.dart';
import '../../widgets/profile_pic.dart';

class EditeProfile extends StatelessWidget {
  const EditeProfile({super.key});

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
                SizedBox(height:28,),
                ProfilePic(),
                SizedBox(height:28,),
                MyTextField(label: 'First Name',),
                SizedBox(height:8,),
                MyTextField(label: 'Email Address',),

              ],),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: MyButton(onTap: (){
                showLogOutDialog( context:context);
              }, buttonText: "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
