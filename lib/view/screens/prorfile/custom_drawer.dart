
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smile_art/binding/edit_profile_binding.dart';
import 'package:smile_art/constant/app_constants.dart';
import 'package:smile_art/view/screens/downloads/downloads.dart';
import 'package:smile_art/view/screens/home/notifications.dart';
import 'package:smile_art/view/screens/prorfile/help_center.dart';
import 'package:smile_art/view/screens/prorfile/notification_setting.dart';
import 'package:smile_art/view/screens/prorfile/privacy_policy.dart';
import 'package:smile_art/view/screens/simulation/simulations.dart';

import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/log_out_dialogue.dart';
import '../../widgets/my_text_widget.dart';
import 'change_password.dart';
import 'edite_profile.dart';
import 'notifications.dart';
import 'terms_conditions.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 140,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(Assets.imagesProfileBg))),
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: CommonImageView(imagePath: Assets.imagesProfile),
                                ),
                              ),
                              Obx(()=> MyText(text: ('${userModelGlobal.value.firstName} ${userModelGlobal.value.lastName}'), size: 18, weight: FontWeight.w600,color:kSecondaryColor,)),
                              Obx(()=> MyText(text: userModelGlobal.value.email, size: 12, weight: FontWeight.w500,color:kSecondaryColor,)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDrawerItem('Edit Profile', Assets.profileEditProfile,
                          () {
                        Get.to(() => EditeProfile(), binding: EditProfileBinding());
                      }),

                      _buildDrawerItem('Change password', Assets.profileChangePa,
                          () {
                         Get.to(() => const ChangePassword());
                      }),
                      _buildDrawerItem('Notification settings', Assets.profileNotif,
                              () {
                            Get.to(() => const NotificationSetting());
                          }),
                      _buildDrawerItem('Privacy & policy',
                          Assets.profileBill, () {
                        Get.to(() => const PrivacyPolicy());
                      }),
                      _buildDrawerItem(
                          'Terms & conditions', Assets.profilePrivacy, () {
                        Get.to(() => const TermsConditions());
                      }),
                      _buildDrawerItem(
                          'Help & support', Assets.profilePrivacy,
                          () {
                         Get.to(() => const HelpCenter());
                      }),
                      _buildDrawerItem(
                          'View downloads', Assets.profileDownlaods,
                              () {
                            Get.to(() => const Downloads());
                          }),
                      _buildDrawerItem(
                          'Your simulation', Assets.profileSimulations,
                              () {
                            Get.to(() => const Simulations());
                          }),
                      const SizedBox(height:5,),
                      Bounce(
                        onPressed: (){
                    showLogOutDialog(context: context);
                        },
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          height:49,
                          width:Get.width/1.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30), color: kSecondaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                          child: Row(
                            children: [
                              Container(
                                height:26,
                                width:26,
                                decoration:BoxDecoration(
                                    color:kRedColor.withOpacity(0.1),
                                    borderRadius:BorderRadius.circular(6)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    Assets.profileLogout,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width:10,),
                              MyText(
                                paddingLeft: 15,
                                text: "Logout",
                                size: 14,
                                color:kDarkColor,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height:48,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    String title,
    String icon,
    VoidCallback ontap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Bounce(
        onPressed: ontap,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height:49,
          width:Get.width/1.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: kSecondaryColor),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          child: Row(
            children: [
              Container(
                height:26,
                width:26,
                decoration:BoxDecoration(
                  color:kPrimaryColor,
                  borderRadius:BorderRadius.circular(6)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    icon,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              const SizedBox(width:10,),
              MyText(
                paddingLeft: 15,
                text: title,
                size: 12,
                color:kDarkColor,
                weight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
