import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import 'my_text_widget.dart';

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        SizedBox(height:12,),
        MyText(
          text: title,
          size: 12,
          weight: FontWeight.w600,
          color:Color(0xff737373),
        ),
        MyText(
          text:
             subTitle,
          size: 12,
          color: kGreyColor,
        )
      ],
    );
  }
}
