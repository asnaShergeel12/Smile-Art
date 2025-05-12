import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import 'package:smile_art/view/widgets/privacy_widget.dart';

import '../../widgets/my_text_widget.dart';
import '../../widgets/profile_appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar("Privacy & policy"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              MyText(
                text: "Smile Art™ Mobile Application - Terms of Use",
                size: 16,
                color: kTextColor,
                weight: FontWeight.w500,
              ),
              SizedBox(
                height: 5,
              ),
              MyText(
                text: "Scope of this Notice",
                size: 12,
                color: kGreyColor,
              ),
              SizedBox(
                height: 18,
              ),
              MyText(
                text:
                    "Smile Art B.V. (“Smile Art”, “we”, “us”, “our”) is committed to protecting your personal data."
                    " This notice applies to all our products, services, websites, applications, and communication channels (collectively, "
                    "“Services”), including our social media accounts such as Instagram (@smile.art.nl) and TikTok (@smile.art.nl).   "
                    "This notice explains what personal data we collect, why we collect it, how long we keep it, and with whom it may be shared. ",
                color: kGreyColor,
                size: 12,
              ),
              PrivacyWidget(
                  title: "What Data We Collect and Why ",
                  subTitle:
                      "We collect personal data from visitors, customers, service providers, and suppliers. Below is a breakdown by category of the types of personal data we collect, the sources, and the purposes: "),
              PrivacyWidget(
                  title: "1. Identifying Data ",
                  subTitle:
                      "Examples: name, email address, phone number, IP address, device ID  Sources: Website forms, emails, social media contact, appointment bookings  Purposes: Scheduling, communication, customer service, marketing, and IT security "),
              PrivacyWidget(
                  title: "2. Demographic Data ",
                  subTitle:
                      "Examples: gender, age, nationality (if provided)  Sources: Intake forms or images submitted for smile consultation  Purposes: Personalized service and service optimization "),
              PrivacyWidget(
                  title: "3. Sensitive Data ",
                  subTitle:
                      "Examples: Oral health, dental information (only with consent)  Sources: Intake, consultation, or uploaded photos  Purposes: Providing personal advice and treatment plans "),
              PrivacyWidget(
                  title: "4. Purchase and Usage Data ",
                  subTitle:
                      "Examples: Products or services you purchase  Sources: Website transactions or direct contact  Purposes: Administration, customer service, statistics, and marketing "),
              PrivacyWidget(
                  title: "5. Internet and Network Activity ",
                  subTitle:
                      "Examples: Pages visited, clicks, interactions with emails or ads  Sources: Our website, cookies, social media  Purposes: Website improvement, ad optimization "),
              PrivacyWidget(
                  title: "6. Location Data ",
                  subTitle:
                      "Sources: Website or mobile browser (only with consent)  Purposes: Finding our practice and location-based marketing "),
              PrivacyWidget(
                  title: "Sharing of Personal Data ",
                  subTitle:
                      "We do not sell your personal data. We may share data with trusted service providers such as cloud providers, accounting systems, marketing partners, and IT support. If you consent to marketing cookies, we may display ads through social networks such as Instagram and TikTok.   You may unsubscribe from marketing communications at any time."),
              SizedBox(
                height: 12,
              ),
              MyText(
                text:
                    "You have the right to:  - Request access to your data  - Have your data corrected or deleted  - Withdraw your consent  - Object to processing  - Request data portability   To exercise these rights, please email info@smileart.nl. We may ask you to verify your identity.",
                size: 12,
                color: kGreyColor,
              ),
              SizedBox(
                height: 12,
              ),
              MyText(
                  text:
                      "Smile Art B.V. does not knowingly collect data from children under the age of 13 without parental or guardian consent. If you believe your child has contacted us without consent, please contact us at info@smileart.nl.Social MediaIf you post publicly using hashtags such as #SmileArtNL, we may request your permission to share your content on our social media accounts, including:  - Instagram: @smile.art.nl  - TikTok: @smile.art.nl   By replying “yes” to our request to share content, you agree to this use. Questions? If you have any questions about how we handle your personal data, feel free to contact us: ",size:12,color:kGreyColor,),
              MyText(text: " 📧 info@smileart.nl",size:12,color:kGreyColor,),
              Row(
                mainAxisAlignment:MainAxisAlignment.end,
                children: [
                MyButton(onTap: (){}, buttonText: "Agree",height:38,width:Get.width/2.5,)
              ],),
              SizedBox(height:18,)
            ],
          ),
        ),
      ),
    );
  }
}
