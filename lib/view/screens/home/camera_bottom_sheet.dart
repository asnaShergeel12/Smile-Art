import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/media_controller.dart';
import 'package:smile_art/view/screens/home/camera.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import '../../../app_enums.dart';
import '../../../generated/assets.dart';

class CameraBottomSheet extends StatelessWidget {
  final mediaController = Get.find<MediaController>();
  CameraBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:18.0),
      child: Column(
        mainAxisSize:MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 40,
              ),
              Container(
                height: 4,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: kGreyColor),
              ),
              Transform.translate(
                offset: const Offset(10, 0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: CommonImageView(
                      svgPath: Assets.iconsCloseIcons,
                    )),
              )
            ],
          ),
          const SizedBox(height:8,),
          MyButton(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);

                if (photo != null) {
                  await mediaController.uploadMedia(
                    file: File(photo.path),
                    mediaType: MediaType.image,
                    progressType: ProgressType.selfie,
                  );
                  CustomSnackbar.success(title: "Success", message: "Your selfie has been saved in media section successfully!");
                  Get.back();
                  print('Captured image path: ${photo.path}');
                } else{
                  CustomSnackbar.error(title: "Error", message: "No selfie was captured. Please try again.");
                }
              }, buttonText: "Take a selfie"),
          const SizedBox(height:16,),
          MyButton(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? teethPhoto = await picker.pickImage(source: ImageSource.camera);

              if (teethPhoto != null) {
                await Get.find<MediaController>().uploadMedia(
                  file: File(teethPhoto.path),
                  mediaType: MediaType.image,
                  progressType: ProgressType.teethSelfie,
                );
                CustomSnackbar.success(title: "Success", message: "Your teeth selfie has been saved in media section successfully!");
                Get.back();
                print('Captured teeth image path: ${teethPhoto.path}');
              } else{
                CustomSnackbar.error(title: "Error", message: "No teeth selfie was captured. Please try again.");
              }
            },
            buttonText: "Take a teeth selfie",
            backgroundColor: Colors.transparent,
            outlineColor: kPrimaryColor,
            fontColor: kPrimaryColor,
          ),
          const SizedBox(height:16,),
          MyButton(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? video = await picker.pickVideo(source: ImageSource.camera);

              if (video != null) {
                await mediaController.uploadMedia(
                  file: File(video.path),
                  mediaType: MediaType.video,
                  progressType: ProgressType.video,
                );
                CustomSnackbar.success(title: "Success", message: "Your video has been saved in media section successfully!");
                Get.back();
                print('Captured video path: ${video.path}');
              }else{
                CustomSnackbar.error(title: "Error", message: "No video was captured. Please try again.");
              }
            },
            buttonText: "Create video",
            backgroundColor: Colors.transparent,
            outlineColor: kPrimaryColor,
            fontColor: kPrimaryColor,
          ),
          const SizedBox(height:28,),
        ],
      ),
    );
  }
}
