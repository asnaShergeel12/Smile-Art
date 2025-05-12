import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bounce/flutter_bounce.dart';


import '../../constant/app_colors.dart';
import 'common_image_widget.dart';
import 'my_text_widget.dart';


class MyButton extends StatelessWidget {
  MyButton({super.key,
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.backgroundColor,
    this.fontColor = kSecondaryColor,
    this.fontSize = 16,
    this.outlineColor = Colors.transparent,
    this.radius = 6,
    this.svgIcon,
    this.haveSvg = false,
    this.choiceIcon,
    this.isleft,
    this.mhoriz = 0,
    this.hasicon,
    this.width=double.infinity,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.mTop = 0,
    this.fontWeight = FontWeight.w700,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  final double radius;
  final double fontSize;
  final Color outlineColor;
  bool? hasicon, isleft, hasshadow, hasgrad;
  //Widget? choiceIcon;
  final Color? backgroundColor, fontColor;
  final String? svgIcon, choiceIcon;
  final bool haveSvg;
  final double mTop, mBottom, mhoriz;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          duration: Duration(milliseconds: 1000),
        ),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn)
      ],
      child: Bounce(
        duration: Duration(milliseconds: 100),
        onPressed: onTap,
        child: Container(
          margin: EdgeInsets.only(
              top: mTop, bottom: mBottom, left: mhoriz, right: mhoriz),
          height: height,
          width:width,
          decoration: hasgrad == true
              ? BoxDecoration(

                  border: Border.all(color: outlineColor),
                  borderRadius: BorderRadius.circular(radius),
                )
              : BoxDecoration(
                  color: backgroundColor ?? kPrimaryColor,
                  border: Border.all(color: outlineColor),
                  borderRadius: BorderRadius.circular(radius),
                ),
          child: Material(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: isleft == true
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                hasicon == true
                    ? Padding(
                        padding: isleft == true
                            ? const EdgeInsets.only(left: 20.0)
                            : const EdgeInsets.only(left: 0),
                        child: CommonImageView(
                          imagePath: choiceIcon,
                          height: 24,
                        ))
                    : const SizedBox.shrink(),
                MyText(
                  paddingLeft: (hasicon == true) ? 10 : 0,
                  text: buttonText,
                  size: fontSize,
                  color: fontColor ?? kSecondaryColor,
                  weight: fontWeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key,
    required this.buttonText,
    required this.onTap,
    this.height = 52,
    this.width = double.infinity,
    this.textSize,
    this.weight,
    this.radius,
    this.customChild,
    this.bgColor,
    this.textColor,
    this.mBottom,
    this.borderColor,
    this.mTop,
  });

  final String buttonText;
  final VoidCallback onTap;
  double? height, textSize, radius,width;
  FontWeight? weight;
  Widget? customChild;
  Color? bgColor, textColor,borderColor;
  double? mTop, mBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop ?? 0, bottom: mBottom ?? 0),
      height: height,
      width:width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        color: bgColor ?? kSecondaryColor,
        border:Border.all(color:borderColor??kPrimaryColor)
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(radius ?? 8),
          child: customChild ?? Center(
                  child: MyText(
                    text: buttonText,
                    size: textSize ?? 16,
                    weight: weight ?? FontWeight.w600,
                    color: textColor ?? kPrimaryColor,
                  ),
                ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyBorderButton extends StatelessWidget {
  MyBorderButton({
    required this.buttonText,
    required this.onTap,
    this.height = 48,
    this.textSize,
    this.weight,
    this.child,
    this.radius,
    this.borderColor,
    this.mBottom,
    this.mTop,
  });

  final String buttonText;
  final VoidCallback onTap;
  double? height, textSize;
  FontWeight? weight;
  Widget? child;
  double? radius;
  Color? borderColor;
  double? mTop, mBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop ?? 0, bottom: mBottom ?? 0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 8),
        color: Colors.transparent,
        border: Border.all(
          width: 1.0,
          color: borderColor ?? kSecondaryColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          child: InkWell(
            onTap: onTap,
            splashColor: kPrimaryColor.withOpacity(0.1),
            highlightColor: kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(radius ?? 8),
            child: child ?? Center(
                    child: MyText(
                      text: buttonText,
                      size: textSize ?? 14,
                      weight: weight ?? FontWeight.w700,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
