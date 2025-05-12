
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';

import 'my_text_widget.dart';

authAppBar(String title) {
  return AppBar(
    toolbarHeight:16,
    backgroundColor:kSecondaryColor,

    bottom:PreferredSize(preferredSize: Size(double.infinity, 60), child:Container(
      decoration:BoxDecoration(
        color:kSecondaryColor,
        border:Border(bottom:BorderSide(color:kBorderColor))
      ),
      child:Padding(
        padding: const EdgeInsets.only(top:8.0,bottom:8),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
          IconButton(onPressed: () {
            Get.back();
          }, icon: Icon(Icons.arrow_back_ios_rounded,size:16,color:kPrimaryColor,)),
          Padding(
            padding: const EdgeInsets.only(top:12.0),
            child: Column(
              children: [
                MyText(
                  text: title,
                  size: 16,
                  weight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
            SizedBox(width:48,)
        ],),
      ),
    )
    ),
  );
}
