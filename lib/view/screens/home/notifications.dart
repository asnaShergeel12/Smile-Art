import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/home/widgets/notification_card.dart';

import '../../../generated/assets.dart';
import '../../widgets/common_image_widget.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/my_text_widget.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar("Notifications"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
              text: "Today",
              size: 16,
              weight: FontWeight.w500,
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return NotificationCard();
              },
            ),
            SizedBox(
              height: 18,
            ),
            MyText(
              text: "Yesterday",
              size: 16,
              weight: FontWeight.w500,
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return NotificationCard();
              },
            ),
            SizedBox(
              height: 18,
            ),
            MyText(
              text: "Nov 14,2024",
              size: 16,
              weight: FontWeight.w500,
            ),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return NotificationCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
