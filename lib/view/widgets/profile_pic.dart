import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import '../../controller/edit_profile_controller.dart';
import '../../generated/assets.dart';
import 'common_image_widget.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EditProfileController>();

    return Obx(() {
      final imageFile = controller.selectedImage.value;
      final imageUrl = controller.profilePic.value;
      return Animate(
        effects: const [MoveEffect(duration: Duration(milliseconds: 400))],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  height: 84,
                  width: 84,
                ),
                ClipOval(
                  child: imageFile != null
                      ? Image.file(
                    imageFile,
                    height: 84,
                    width: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network(
                      controller.fallbackImage,
                      height: 84,
                      width: 84,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Image.network(
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : controller.fallbackImage,
                    height: 84,
                    width: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.network(
                      controller.fallbackImage,
                      height: 84,
                      width: 84,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CommonImageView(
                            svgPath: Assets.profileEditProfile,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      );
    });
  }
}

