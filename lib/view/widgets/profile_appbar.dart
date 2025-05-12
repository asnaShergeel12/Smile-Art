
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_colors.dart';
import 'my_text_widget.dart';

profileAppbar(String title){
  return AppBar(
    centerTitle:true,
    backgroundColor:kPrimaryColor,
    elevation:0,
    leading:IconButton(onPressed: () {
      Get.back();
    }, icon: Container(

      decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(5),
        color:kSecondaryColor.withOpacity(0.20)
      ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back_ios_rounded,size:16,color:kSecondaryColor,),
        ))),
    title: MyText(
      text: title,
      size: 16,
      weight: FontWeight.w500,
      color:kSecondaryColor,
    ),
  );
}