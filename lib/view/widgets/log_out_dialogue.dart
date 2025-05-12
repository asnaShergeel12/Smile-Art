import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/auth_service.dart';
import '../../constant/app_colors.dart';
import 'my_button.dart';
import 'my_text_widget.dart';


Future<void> showLogOutDialog({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierColor:kPrimaryColor.withOpacity(0.5),
    barrierDismissible: false, // Prevent dismiss on tap outside
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText(text: 'Logout',size:24,weight:FontWeight.w700,textAlign:TextAlign.center,),
              const SizedBox(height: 10),
              MyText(
                textAlign:TextAlign.center,
                text:
                    'Are you sure you want to logout?',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(
                  width:MediaQuery.sizeOf(context).width/3,
                    child: MyBorderButton(buttonText: "Yes", borderColor:kBorderColor,
                        onTap: (){
                      AuthService().logout(context);
                      Get.back();
                        }),),
               MyButton(onTap: (){
                 Get.back();
               }, buttonText: "No",width:MediaQuery.sizeOf(context).width/3,backgroundColor:kRedColor,)
              ],),
              SizedBox(height:18,)
            ],
          ),
        ),
      );
    },
  );
}
