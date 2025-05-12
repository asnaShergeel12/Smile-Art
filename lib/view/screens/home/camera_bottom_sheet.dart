import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/home/camera.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_button.dart';

import '../../../generated/assets.dart';

class CameraBottomSheet extends StatelessWidget {
  const CameraBottomSheet({super.key});

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
              SizedBox(
                width: 40,
              ),
              Container(
                height: 4,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: kGreyColor),
              ),
              Transform.translate(
                offset: Offset(10, 0),
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
          SizedBox(height:8,),
          MyButton(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);

                if (photo != null) {
                  // Do something with the captured photo, e.g., display or upload
                  print('Captured image path: ${photo.path}');
                }
              }, buttonText: "Take a selfie"),
          SizedBox(height:16,),
          MyButton(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo = await picker.pickImage(source: ImageSource.camera);

              if (photo != null) {
                // Do something with the captured photo, e.g., display or upload
                print('Captured image path: ${photo.path}');
              }
            },
            buttonText: "Take a teeth selfie",
            backgroundColor: Colors.transparent,
            outlineColor: kPrimaryColor,
            fontColor: kPrimaryColor,
          ),
          SizedBox(height:16,),
          MyButton(
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final XFile? photo = await picker.pickImage(source: ImageSource.camera);

              if (photo != null) {
                // Do something with the captured photo, e.g., display or upload
                print('Captured image path: ${photo.path}');
              }
            },
            buttonText: "Create video",
            backgroundColor: Colors.transparent,
            outlineColor: kPrimaryColor,
            fontColor: kPrimaryColor,
          ),
          SizedBox(height:28,),
        ],
      ),
    );
  }
}
