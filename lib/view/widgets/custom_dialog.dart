import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import 'my_button.dart';
import 'my_text_widget.dart';


Future<void> showCustomDialog({
  required BuildContext context,
  String? title,
  String? subtitle,
  String? image,
  String? confirmText,
  String? cancelText,
  required VoidCallback  onTap,
  Color? confirmColor,
  bool isSubTitle=true
}) {
  return showDialog(
    context: context,
    barrierColor:kPrimaryColor.withOpacity(0.5),
    barrierDismissible: false, // Prevent dismiss on tap outside
    builder: (BuildContext context) {
      return Dialog(
        insetPadding:EdgeInsets.symmetric(horizontal:24),
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
              SizedBox(height:18,),
              if (image != null) ...[
                Image.asset(
                  image,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                isSubTitle?  const SizedBox(height: 20):SizedBox(height:10,),
              ],
              MyText(text:  title ?? 'Verification Successful',size:24,weight:FontWeight.w700,textAlign:TextAlign.center,),
              const SizedBox(height: 10),
              isSubTitle? MyText(
               textAlign:TextAlign.center,
               text:  subtitle ??
                 '',
               color:kGreyColor,
             ):SizedBox(),
            isSubTitle?  const SizedBox(height: 20):SizedBox(height:10,),
             MyButton(onTap:onTap, buttonText: confirmText ?? "",fontColor:kSecondaryColor,),
              isSubTitle?  const SizedBox(height: 0):SizedBox(height:28,),
            ],
          ),
        ),
      );
    },
  );
}
