// ignore: must_be_immutable
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Texts extends StatelessWidget {
  Texts({super.key, required this.children});
  List<InlineSpan> children;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign:TextAlign.start,
        text: TextSpan(children: children,style:TextStyle( fontFamily: "Manrope")));
  }
}
