import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';
import '../../widgets/rich_texts.dart';

class ArticleDetails extends StatelessWidget {
   ArticleDetails({super.key});
final List<String> _imagesList=[
  Assets.imagesArtOne,
  Assets.imagesArtTwo,
  Assets.imagesArtThree,
  Assets.imagesArtFour,
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Article detail"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: SingleChildScrollView(
          physics:BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              CommonImageView(
                imagePath: Assets.imagesArticle,
              ),
              SizedBox(height:15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    text: "Clean your aligners right",
                    size: 18,
                    weight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                  Row(
                    children: [
                      CommonImageView(
                        svgPath: Assets.iconsWatchIc,
                      ),
                      MyText(
                        text: ":15 mints",
                        size: 12,
                        color: kDarkColor,
                      )
                    ],
                  )
                ],
              ),

              MyText(
                text: "Keep your aligners fresh and clean",
                color: kDarkColor,
              ),
              SizedBox(height:10,),
              Row(
                children: [
                  CommonImageView(
                    height: 28,
                    imagePath: Assets.imagesProfile,
                  ),
                  SizedBox(width:4,),
                  Row(
                    children: [
                      MyText(
                        text: "Author : ",
                        size: 12,
                        weight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                      MyText(text: "John Doe", size: 12, weight: FontWeight.w500)
                    ],
                  )
                ],
              ),
              SizedBox(height:8,),
              Row(
                children: [
                  CommonImageView(
                    height:18,
                    svgPath: Assets.iconsDate,
                  ),
                  SizedBox(width:5,),
                  Row(
                    children: [
                      MyText(
                        text: "Published on: ",
                        size: 12,
                        weight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                      MyText(
                          text: "7th feb,2025", size: 12, weight: FontWeight.w500)
                    ],
                  )
                ],
              ),
              SizedBox(height:8,),
              Divider(
                color: kBorderColor,
              ),
              SizedBox(height:8,),
              MyText(
                text: "Step-by-Step Guide to Clean Your Aligners",
                size: 16,
                weight: FontWeight.w600,
              ),
              SizedBox(height:4,),
              ListView.builder(
                itemCount:4,
                  shrinkWrap:true,
                  physics:NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom:12.0),
                  child: Texts(children: [
                    TextSpan(
                      text: "- Step ${i+1}: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: kGreyColor),
                    ),
                    TextSpan(
                      text:
                          "Interdum et malesuada fames ac ante ipsum primis in faucibus."
                              " Morbi ut nisi odio. Nulla facilisi Interdum et malesuada fames ac ante ipsum primis in faucibus."
                              " Morbi ut nisi odio. ",
                      style: TextStyle(fontSize: 12, color: kGreyColor),
                    )
                  ]),
                );
              }),
              SizedBox(height:18,),
              MyText(text: "Visual guide",size:16,weight:FontWeight.w600,),
              SizedBox(height:10,),
              GridView.builder(
                itemCount: 4,
                  shrinkWrap:true,
                  physics:NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing:10,
                      crossAxisSpacing:10,
                      crossAxisCount: 2
              ), itemBuilder: (context,i){
                return CommonImageView(
                  imagePath:_imagesList[i],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
