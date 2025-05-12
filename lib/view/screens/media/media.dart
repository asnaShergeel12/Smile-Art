import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/home/video_playing.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class Media extends StatefulWidget {
  const Media({super.key});

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  final List<String> _categoryList = [
    "Selfies",
    "Teeth Selfie",
    "Videos",
  ];
  int selectedIndex = 0;

  void setIndex(int i) {
    setState(() {
      selectedIndex = i;
    });
  }

  int get getIndex => selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Media",isLeading: false),
      body: SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height:18,),
              SizedBox(
                height: 32,
                child: ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: EdgeInsets.only(left: i == 0 ? 18.0 : 0, right: 6),
                        child: GestureDetector(
                          onTap: () {
                            setIndex(i);
                          },
                          child: Container(
                            height: 32,
                            width: 112,
                            decoration: BoxDecoration(
                                color: getIndex == i
                                    ? kPrimaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: kPrimaryColor)),
                            child: Center(
                                child: MyText(
                                  text: _categoryList[i],
                                  color:
                                  getIndex == i ? kSecondaryColor : kPrimaryColor,
                                  size: 12,
                                  weight: FontWeight.w600,
                                )),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height:18,),
              Padding(
                padding: const EdgeInsets.only(left:18.0),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 22,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width:6,),
                    MyText(
                      text: "Your Smile Transformation Journey",
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(height:18,),
              // Display content based on selected category
              if (getIndex == 0 || getIndex == 1) // Selfies or Teeth Selfie
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 18.0 : 0, right: 10),
                          child: Container(
                            height: 400,
                            width: 215,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(image: AssetImage(Assets.imagesSelf))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    PopupMenuButton(
                                      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                      color: kSecondaryColor,
                                      menuPadding: EdgeInsets.zero,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.more_vert, color: kSecondaryColor, size: 20,),
                                      onSelected: (value) {
                                        // Handle menu item selection
                                        switch (value) {
                                          case 'edit':
                                            break;
                                          case 'delete':
                                            break;
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                            height: 30,
                                            padding: EdgeInsets.only(left: 8),
                                            value: 'edit',
                                            child: MyText(text: "Edit", size: 8,)
                                        ),
                                        PopupMenuItem(
                                            height: 30,
                                            padding: EdgeInsets.only(left: 8),
                                            value: 'delete',
                                            child: MyText(text: "Delete", size: 8,)
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    MyText(
                                      text: "12/Jan/2025",
                                      size: 24,
                                      weight: FontWeight.w700,
                                      color: kSecondaryColor,
                                    ),
                                    MyText(
                                      text: "Aligner # 1",
                                      size: 18,
                                      weight: FontWeight.w700,
                                      color: kSecondaryColor,
                                    ),
                                    SizedBox(height: 18,),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              if (getIndex == 2) // Videos
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(left: i == 0 ? 18.0 : 0, right: 10),
                          child: GestureDetector(
                            onTap:(){
                              Get.to(VideoPlaying());
                            },
                            child: Container(
                              height: 400,
                              width: 215,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  image: DecorationImage(image: AssetImage(Assets.imagesVideoSel))
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      PopupMenuButton(
                                        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                        color: kSecondaryColor,
                                        menuPadding: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Icons.more_vert, color: kSecondaryColor, size: 20,),
                                        onSelected: (value) {
                                          // Handle menu item selection
                                          switch (value) {
                                            case 'edit':
                                              break;
                                            case 'delete':
                                              break;
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                              height: 30,
                                              padding: EdgeInsets.only(left: 8),
                                              value: 'edit',
                                              child: MyText(text: "Edit", size: 8,)
                                          ),
                                          PopupMenuItem(
                                              height: 30,
                                              padding: EdgeInsets.only(left: 8),
                                              value: 'delete',
                                              child: MyText(text: "Delete", size: 8,)
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      MyText(
                                        text: "12/Jan/2025",
                                        size: 24,
                                        weight: FontWeight.w700,
                                        color: kSecondaryColor,
                                      ),
                                      MyText(
                                        text: "Aligner # 1",
                                        size: 18,
                                        weight: FontWeight.w700,
                                        color: kSecondaryColor,
                                      ),
                                      SizedBox(height: 18,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}