import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/home/article_details.dart';
import 'package:smile_art/view/screens/home/video_playing.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';
import 'widgets/educational_hub_card.dart';

class EducationalHub extends StatelessWidget {
  const EducationalHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Educational hub",isLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(
          children: [
            SizedBox(height:18,),
            Row(
              children: [
                Container(
                  width: 4,
                  height: 22,
                  color: kPrimaryColor,
                ),
                SizedBox(width:6,),
                MyText(
                  text: "Educational hub",
                  size: 16,
                  weight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(height:18,),
            ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap:(){
                      if(i==0){
                        Get.to(VideoPlaying());
                      }else if(i==1){
                        Get.to(ArticleDetails());
                      }
                    },
                    child: EducationalHubCard(
                        content: i == 1 || i == 3
                            ? Assets.imagesHub
                            : Assets.imagesVideoCard,
                        title: "Clean Your Aligners Right",
                        time: "Watch Time:15 mints",
                        date: "Published on: Feb 12,2025"),
                  );
                })
          ],
        ),
      ),
    );
  }
}
