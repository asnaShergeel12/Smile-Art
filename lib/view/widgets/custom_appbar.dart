
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_text_widget.dart';

customAppbar(String title,{bool isLeading=true}){
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle:true,
    backgroundColor:Colors.transparent,
    elevation:0,
    leading:isLeading?IconButton(onPressed: () {
      Get.back();
    }, icon: Icon(Icons.arrow_back_ios_rounded,size:16,)):null,
    title: MyText(
      text: title,
      size: 16,
      weight: FontWeight.w500,

    ),
  );
  }