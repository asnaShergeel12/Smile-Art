import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';

// ignore: must_be_immutable
class CustomCheckBox extends StatelessWidget {
  CustomCheckBox(
      {super.key,
      required this.isActive,
      required this.onTap,
      this.unSelectedColor,
      this.selectedColor,
      this.iscircle});

  final bool isActive;
  final VoidCallback onTap;
  Color? unSelectedColor, selectedColor;
  bool? iscircle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 230,
        ),
        curve: Curves.easeInOut,
        height: 19,
        width: 19,
        decoration: BoxDecoration(
          color: isActive
              ? selectedColor ?? kPrimaryColor
              : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color: isActive
                ? unSelectedColor ?? kPrimaryColor
                : unSelectedColor ?? kGreyColor,
          ),
          borderRadius: BorderRadius.circular(iscircle == true ? 50 : 5),
        ),
        child: !isActive
            ? SizedBox()
            : Icon(
                Icons.check,
                size: 13,
                color: isActive == true ? kSecondaryColor : Colors.transparent,
              ),
      ),
    );
  }
}
