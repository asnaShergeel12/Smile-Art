import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../../generated/assets.dart';

class DownloadCard extends StatelessWidget {
  const DownloadCard(
      {super.key,
      required this.content,
      required this.title,
      required this.time,
      required this.date});

  final String content;
  final String title, time, date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:15.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: kBorderColor),
            color: Color(0xffF6F6F6)),
        child: Padding(
          padding: const EdgeInsets.only(left:14.0,bottom:14,top:14,right:14),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImageView(
                    radius: 5,
                    height:90,
                    fit:BoxFit.fill,
                    imagePath: content,
                  ),
                  SizedBox(width:8,),
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: title,
                        size: 12,
                        weight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                      SizedBox(height:5,),
                      Row(
                        children: [
                          CommonImageView(
                            svgPath: Assets.iconsDate,
                          ),
                          SizedBox(width:4,),
                          MyText(
                            text: date,
                            size: 10,
                            weight: FontWeight.w500,
                            color: kDarkColor,
                          ),
                        ],
                      ),
                      SizedBox(height:5,),
                      Row(
                        children: [
                          CommonImageView(
                            svgPath: Assets.iconsWatchIc,
                          ),
                          SizedBox(width:4,),
                          MyText(
                            text: time,
                            size: 10,
                            weight: FontWeight.w500,
                            color: kDarkColor,
                          ),
                        ],
                      ),
                      SizedBox(height:5,),
                      MyText(
                        text: "Downloaded",
                        size: 10,
                        weight: FontWeight.w500,
                        color: kPrimaryColor,
                      )
                    ],
                  )
                ],
              ),
              CommonImageView(
                svgPath: Assets.iconsArrowFar,
              )
            ],
          ),
        ),
      ),
    );
  }
}
