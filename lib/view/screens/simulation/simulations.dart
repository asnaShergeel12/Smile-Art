import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/custom_appbar.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';

import '../../../generated/assets.dart';

class Simulations extends StatelessWidget {
  const Simulations({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:customAppbar("Simulation"),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal:18.0),
        child: Column(children: [
          Row(children: [
            Container(
              width:4,
              height:22,
              color:kPrimaryColor,
            ),
            SizedBox(width:10,),
            MyText(text: "Your simulation",size:16,weight:FontWeight.w700,)
          ],),
          SizedBox(height:18,),
          CommonImageView(
            imagePath:Assets.imagesSimulation,
          )
        ],),
      ),
    );
  }
}
