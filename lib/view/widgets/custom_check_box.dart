import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_colors.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  CustomCheckBox(
      {super.key,
      required this.isActive,
      required this.onTap,
      this.unSelectedColor,
      this.selectedColor,
      this.isCircle});

  final bool isActive;
  final VoidCallback onTap;
  Color? unSelectedColor, selectedColor;
  bool? isCircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 230,
        ),
        curve: Curves.easeInOut,
        height: 19,
        width: 19,
        decoration: BoxDecoration(
          color: isActive ? selectedColor ?? kPrimaryColor : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color: isActive
                ? unSelectedColor ?? kPrimaryColor
                : unSelectedColor ?? kGreyColor,
          ),
          borderRadius: BorderRadius.circular(isCircle == true ? 50 : 5),
        ),
        child: isActive
            ? Icon(
                Icons.check,
                size: 13,
                color: isActive == true ? kSecondaryColor : Colors.transparent,
              )
            : const SizedBox(),
      ),
    );
  }
}
