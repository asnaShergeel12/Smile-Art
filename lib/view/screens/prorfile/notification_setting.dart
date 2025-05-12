
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';

import '../../widgets/my_text_widget.dart';
import '../../widgets/profile_appbar.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({super.key});

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool _isValue=true;
  bool _isEmail=false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:profileAppbar("Notification Settings"),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          SizedBox(height:38,),
          Container(
            height:62,
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:kSecondaryColor,
                boxShadow:[
                  BoxShadow(
                      offset:Offset(0, 0),
                      blurRadius:20,
                      color:Color(0xffC0DCEC).withOpacity(0.40)
                  )
                ]
            ),
            child:Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: "Push Notifications",color:kGreyColor,size:16,),
                  Transform.scale(
                    scale:0.6,
                    child: CupertinoSwitch(
                      activeColor:kPrimaryColor,
                        value:_isValue , onChanged: (val){
                      setState(() {
                        _isValue=val;
                      });
                    }),
                  )
                ],),
            ),
          ),
          SizedBox(height:12,),
          Container(
            height:62,
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:kSecondaryColor,
                boxShadow:[
                  BoxShadow(
                      offset:Offset(0, 0),
                      blurRadius:20,
                      color:Color(0xffC0DCEC).withOpacity(0.40)
                  )
                ]
            ),
            child:Padding(
              padding: const EdgeInsets.only(left:12.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: "Email Notifications",color:kGreyColor,size:16,),
                  Transform.scale(
                    scale:0.6,
                    child: CupertinoSwitch(
                        activeColor:kPrimaryColor,
                        value:_isEmail , onChanged: (val){
                      setState(() {
                        _isEmail=val;
                      });
                    }),
                  )
                ],),
            ),
          )

        ],),
      ),
    );
  }
}
