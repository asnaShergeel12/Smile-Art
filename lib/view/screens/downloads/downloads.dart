import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/downloads/widgets/download_card.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class Downloads extends StatelessWidget {
  const Downloads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Downloads"),
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
                SizedBox(width:3,),
                CommonImageView(
                  svgPath: Assets.iconsDownloads,
                ),
                SizedBox(width:3,),
                MyText(
                  text: "Downloads for you",
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
                  return DownloadCard(
                      content: i == 1 || i == 3
                          ? Assets.imagesPdfImage
                          : Assets.imagesVideoCard,
                      title: "Clean Your Aligners Right",
                      time: "Watch Time:15 mints",
                      date: "Published on: Feb 12,2025");
                })
          ],
        ),
      ),
    );
  }
}
