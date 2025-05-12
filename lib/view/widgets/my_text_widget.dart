import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {

  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  List<Shadow>? shadow;
  final int? maxLines;
  final Paint? paint;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;

  MyText({
    Key? key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.paint,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.shadow,
    this.fontStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:onTap,
      child: Text(
              "$text",
              style: TextStyle(
                foreground: paint,
                shadows: shadow,
                fontSize: size ?? 14,
                color: color ,
                fontWeight: weight,
                decoration: decoration,
                decorationColor: color,
                decorationThickness: 2,
                fontFamily: "Manrope",
                height: lineHeight,
                fontStyle: fontStyle,
                letterSpacing: 0.5,
              ),
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: textOverflow,
      ),
    );
  }
}
