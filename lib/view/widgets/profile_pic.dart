import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/app_colors.dart';
import '../../generated/assets.dart';
import 'common_image_widget.dart';
import 'my_text_widget.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key, this.path, this.first, this.last});

  final String? path, first, last;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [MoveEffect(duration: Duration(milliseconds: 400))],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 84,
                    width: 84,
                    child: Image.asset(
                      Assets.imagesProfile,
                      color: kPrimaryColor,
                    ),
                  ),
                  CommonImageView(
                    imagePath: widget.path ?? Assets.imagesProfile,
                    height: 84,
                    width: 84,
                    radius: 200,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
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
                      ))
                ],
              ),
            ],
          ),
          SizedBox(height:8,),
          MyText(
            text: "Samuel",
            color: kSecondaryColor,
            weight:FontWeight.w600,
          ),
          MyText(
            text: "Samuel@gmail.com",
            color: kSecondaryColor,
            weight:FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
