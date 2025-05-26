import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/constant/app_constants.dart';
import 'package:smile_art/view/screens/home/notifications.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';
import '../prorfile/custom_drawer.dart';
import 'camera_bottom_sheet.dart';
import 'widgets/home_gauge.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AdvancedDrawerController _advancedDrawerController =
      AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: _advancedDrawerController,
      backdropColor: kPrimaryColor,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: CustomDrawer(),
      // Your custom drawer widget
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _advancedDrawerController.showDrawer();
                },
                child: CommonImageView(
                  height: 44,
                  imagePath: Assets.imagesProfile,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: "Welcome 👋",
                    size: 18,
                    color: kPrimaryColor,
                    weight: FontWeight.w700,
                  ),
                  Obx(()=> MyText(
                      text: userModelGlobal.value.firstName,
                      size: 12,
                      weight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  )
                ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(Notifications());
                    },
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor.withOpacity(0.1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CommonImageView(
                          svgPath: Assets.iconsPriNoti,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 4,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: kRedColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 152,
                  width: Get.width,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(Assets.imagesHomeFrame),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          text: "Curious about \nyour new smile?",
                          size: 18,
                          weight: FontWeight.w700,
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MyText(
                          text:
                              "Check your future smile with \nour smart teeth simulation",
                          size: 12,
                          weight: FontWeight.w500,
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        MyButton(
                          onTap: () {
                            Get.bottomSheet(
                                backgroundColor: kSecondaryColor,
                                CameraBottomSheet());
                          },
                          buttonText: "Try Now",
                          fontSize: 10,
                          backgroundColor: kSecondaryColor,
                          width: Get.width / 3,
                          height: 27,
                          fontColor: kDarkColor,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kPrimaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CommonImageView(
                                  svgPath: Assets.iconsCalenderTime,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "5 Days Left Of 15 Days ",
                                  size: 18,
                                  weight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                                MyText(
                                  text: "Till your next aligner",
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: kGreyColor,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: LinearPercentIndicator(
                              backgroundColor: kSecondaryColor,
                              padding: EdgeInsets.zero,
                              linearGradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.9),
                                    Color(0xff0099B9),
                                    kPrimaryColor
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 18.0,
                              barRadius: Radius.circular(30),
                              percent: 0.6,
                              center: MyText(
                                text: "5 days",
                                size: 10,
                                weight: FontWeight.w500,
                                color: kDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 38,
                ),
                HoursOutGauge(),
                SizedBox(
                  height: 18,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: kPrimaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CommonImageView(
                                  imagePath: Assets.iconsSmile,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: "100 Days Left Of 120 Days",
                                  size: 18,
                                  weight: FontWeight.w600,
                                  color: kPrimaryColor,
                                ),
                                MyText(
                                  text: "Till your perfect smile",
                                  size: 12,
                                  weight: FontWeight.w500,
                                  color: kGreyColor,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 6),
                            child: LinearPercentIndicator(
                              backgroundColor: kSecondaryColor,
                              padding: EdgeInsets.zero,
                              linearGradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.9),
                                    Color(0xff0099B9),
                                    kPrimaryColor
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              animation: true,
                              animationDuration: 1000,
                              lineHeight: 18.0,
                              barRadius: Radius.circular(30),
                              percent: 0.3,
                              center: MyText(
                                text: "20 days",
                                size: 10,
                                weight: FontWeight.w500,
                                color: kDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
