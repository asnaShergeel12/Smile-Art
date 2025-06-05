import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/controller/media_controller.dart';
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
    return Obx((){
      return Stack(
          children: [
            _buildSheetContent(context),
            if(mediaController.isUploading.value)
              Container(
                height: 300,
                color: kPrimaryColor.withOpacity(0.5),
                child: const Center(child:CircularProgressIndicator( color: kSecondaryColor,)),
              )
          ],
        );
    });
  }

  Widget _buildSheetContent(context){
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
            onTap: ()=>_handleMediaUpload(
              source: ImageSource.camera,
              mediaType: MediaType.image,
              progressType: ProgressType.selfie,
            ), buttonText: "Take a selfie"),
        const SizedBox(height:16,),
        MyButton(
          onTap: ()=> _handleMediaUpload(
            source: ImageSource.camera,
            mediaType: MediaType.image,
            progressType: ProgressType.teethSelfie,
          ),
          buttonText: "Take a teeth selfie",
          backgroundColor: Colors.transparent,
          outlineColor: kPrimaryColor,
          fontColor: kPrimaryColor,
        ),
        const SizedBox(height:16,),
        MyButton(
          onTap: ()=> _handleMediaUpload(
          source: ImageSource.camera,
          mediaType: MediaType.video,
          progressType: ProgressType.video,
        ),
          buttonText: "Create video",
          backgroundColor: Colors.transparent,
          outlineColor: kPrimaryColor,
          fontColor: kPrimaryColor,
        ),
        const SizedBox(height:28,),
      ],),
    );
  }

  Future<void> _handleMediaUpload({
    required ImageSource source,
    required MediaType mediaType,
    required ProgressType progressType,
  }) async {
    final picker = ImagePicker();
    final XFile? file = mediaType == MediaType.video
        ? await picker.pickVideo(source: source)
        : await picker.pickImage(source: source);

    if (file != null) {
      try {
        mediaController.isUploading.value = true;
        await mediaController.uploadMedia(
          file: File(file.path),
          mediaType: mediaType,
          progressType: progressType,
        );
        CustomSnackbar.success(
          title: "Success",
          message: "Your ${progressType.name} has been saved in media section successfully!",
        );
        await Future.delayed(const Duration(seconds: 5));
        Get.back();
      } catch (e) {
        CustomSnackbar.error(
          title: "Upload Failed",
          message: "An error occurred: $e",
        );
      } finally {
        mediaController.isUploading.value = false;
      }
    } else {
      CustomSnackbar.error(
        title: "Error",
        message: "No ${progressType.name} was captured. Please try again.",
      );
    }
  }

}
