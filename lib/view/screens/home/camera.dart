import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            physics:BouncingScrollPhysics(),
            child: Column(
              children: [
              SizedBox(height:18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap:(){Get.back();},
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kSecondaryColor.withOpacity(0.15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonImageView(
                          svgPath: Assets.iconsClose,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height:18,),
              Stack(
                children: [
                  CommonImageView(
                    imagePath: Assets.imagesCameraImage,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration:BoxDecoration(
                          gradient:LinearGradient(colors: [
                            Color(0xff452B1D).withOpacity(0),
                            Color(0xff452B1D).withOpacity(0),
                            kTextColor.withOpacity(0.9)
                          ],
                              begin:Alignment.topCenter,
                              end:Alignment.bottomCenter
                          )
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom:18.0),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.end,
                          children: [
                            MyText(
                              text: "12/Jan/2025",
                              size: 25,
                              weight: FontWeight.w700,
                              color: kSecondaryColor,
                            ),
                            MyText(text: "Aligner # 1",size:18,weight:FontWeight.w600,color:kSecondaryColor,)
                          ],
                        ),
                      )),

                ],
              ),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                  CommonImageView(
                    height:50,
                    imagePath:Assets.iconsVideoIc,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo = await picker.pickImage(source: ImageSource.camera);

                      if (photo != null) {
                        // Do something with the captured photo, e.g., display or upload
                        print('Captured image path: ${photo.path}');
                      }
                    },

                    child: CommonImageView(
                      height:89,
                      imagePath:Assets.iconsRedCamer,
                    ),
                  ),
                  CommonImageView(
                    height:50,
                    imagePath:Assets.iconsCameraIc,
                  ),

                ],),
                SizedBox(height:18,),
                SizedBox(height: 48,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
