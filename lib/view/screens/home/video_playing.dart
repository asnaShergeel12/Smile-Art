import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class VideoPlaying extends StatelessWidget {
  const VideoPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppbar("Video playing"),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            SizedBox(height:18,),
          Stack(
            children: [
              CommonImageView(
                imagePath:Assets.imagesPlayingVedio,
              ),
              Positioned.fill(child:Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  CommonImageView(
                    svgPath:Assets.iconsIcPlay,
                  ),
                ],
              ))
            ],
          ),
      SizedBox(height:18,),
      ClipRRect(
        borderRadius:BorderRadius.circular(30),
        child: LinearProgressIndicator(
          backgroundColor:kPrimaryColor.withOpacity(0.4), // Background color
          valueColor:
          const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Progress color
          value: 0.5, // Set progress to 50%
        ),
      ),
          SizedBox(height:15,),
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
            MyText(text: "1:06",size:13,weight:FontWeight.w700,),
            MyText(text: "3:28",size:13,weight:FontWeight.w700,),
          ],),
            SizedBox(height:8,),
          MyText(text: "Clean Your Aligners Right",weight:FontWeight.w700,color:kPrimaryColor,),
          MyText(text: "Keep your aligners fresh",size:12,color:kDarkColor,weight:FontWeight.w500,),
            SizedBox(height:18,),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
              IconButton(onPressed:(){}, icon: CommonImageView(
                svgPath:Assets.iconsReplay,
              )),
              Row(children: [
                IconButton(onPressed:(){}, icon: CommonImageView(
                  svgPath:Assets.iconsRev,
                )),
                SizedBox(width:6,),
                Container(
                  height:75,
                  width:75,
                  decoration:BoxDecoration(
                    shape:BoxShape.circle,
                    color:kPrimaryColor
                  ),
                  child:Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: CommonImageView(
                      svgPath:Assets.iconsPause,
                    ),
                  ),
                ),
                SizedBox(width:6,),
                IconButton(onPressed:(){}, icon: CommonImageView(
                  svgPath:Assets.iconsFar,
                )),
              ],),
              IconButton(onPressed:(){}, icon: CommonImageView(
                svgPath:Assets.iconsRepeat,
              )),
            ],)
        ],),
      ),
    );
  }
}
