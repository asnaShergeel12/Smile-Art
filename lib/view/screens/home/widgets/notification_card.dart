import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../constant/app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../widgets/common_image_widget.dart';
import '../../../widgets/my_text_widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.20,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Container(
                width:43,
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:kRedColor.withOpacity(0.22)
                ),
                child: Center(
                  child: CommonImageView(
                    svgPath: Assets.iconsDeleteIcon,
                  ),
                ),
              ),
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            // Get.to(() => PartnerAlertPckageDetailScreen());
          },
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  boxShadow:[
                    BoxShadow(offset:Offset(0, 4),
                        blurRadius:4,
                        color:kTextColor.withOpacity(0.04)
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:48,
                      width:48,
                      decoration:BoxDecoration(
                          shape:BoxShape.circle,
                          color:kPrimaryColor
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CommonImageView(svgPath:Assets.iconsNotifications),
                      ),
                    ),
                    SizedBox(width:6,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height:4,),
                          MyText(
                            text:"Great news! Your assignment is 100% \nunique",
                            size: 12,
                            weight: FontWeight.w500,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right:14,
                bottom:10,
                child: MyText(
                  text: "2 minutes ago",
                  size: 12,
                  color:kGreyColor,

                  weight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
