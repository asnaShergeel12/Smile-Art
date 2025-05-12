import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/rich_texts.dart';

import '../../widgets/my_button.dart';
import '../../widgets/my_text_widget.dart';
import '../../widgets/privacy_widget.dart';
import '../../widgets/profile_appbar.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar("Terms & Conditions"),
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
              Texts(
                  children: [
                TextSpan(text: "Smile Art™ Mobile Application - Terms of Use",
                    style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kTextColor)),
                TextSpan(text:" Last updated: March 22, 2025",  style: TextStyle(fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kTextColor))
              ]),
              SizedBox(
                height: 18,
              ),
              MyText(
                text:
                "Welkom bij de Smile Art™ mobiele applicatie (de 'Applicatie'). Deze gebruiksvoorwaarden ('Voorwaarden') zijn van toepassing op jouw gebruik van onze Applicatie, aangeboden door Smile Art B.V., gevestigd in Nederland ('Smile Art', 'wij', 'ons', 'onze'). Door de Applicatie te downloaden, installeren of gebruiken, ga je akkoord met deze Voorwaarden. Indien je niet akkoord gaat, mag je de Applicatie niet gebruiken. ",
                color: kGreyColor,
                size: 12,
              ),
              PrivacyWidget(
                  title: "1. Doel van de Applicatie ",
                  subTitle:
                  "De Smile Art Applicatie biedt informatie over onze alignerbehandelingen en faciliteert communicatie tussen jou en jouw Smile Art-behandelaar... "),
              PrivacyWidget(
                  title: "2. Smile Art Virtuele Behandeling (indien beschikbaar) ",
                  subTitle:
                  "De virtuele controlefunctie stelt jouw behandelaar in staat je voortgang op afstand te monitoren via foto's en meldingen... "),
              PrivacyWidget(
                  title: "2. Demographic Data ",
                  subTitle:
                  "Examples: gender, age, nationality (if provided)  Sources: Intake forms or images submitted for smile consultation  Purposes: Personalized service and service optimization "),
              PrivacyWidget(
                  title: "3. Licentie ",
                  subTitle:
                  "Smile Art verleent jou een beperkte, herroepbare, niet-exclusieve licentie om de Applicatie te gebruiken...4. LeeftijdsvereisteJe moet minimaal 12 jaar oud zijn om de Applicatie te gebruiken... "),
              PrivacyWidget(
                  title: "5. Jouw Gegevens (User Content) ",
                  subTitle:
                  "Door het gebruik van de Applicatie geef je Smile Art toestemming om jouw geüploade gegevens te verwerken... "),
              PrivacyWidget(
                  title: "6. Intellectuele Eigendom ",
                  subTitle:
                  "Alle rechten op de Applicatie, inclusief software, inhoud en ontwerpen, blijven eigendom van Smile Art... "),
              PrivacyWidget(
                  title: "7. Beperkingen ",
                  subTitle:
                  "Je mag de Applicatie niet reverse-engineeren, verkopen, gebruiken voor onwettige doeleinden... "),
              PrivacyWidget(
                  title: "8. Aansprakelijkheid en Garanties ",
                  subTitle:
                  "De Applicatie wordt geleverd 'zoals deze is'. Smile Art geeft geen garanties op foutloosheid of resultaten... "),
              PrivacyWidget(title: "9. Beëindiging van Gebruik ", subTitle: "Zowel jij als Smile Art kunnen deze overeenkomst op elk moment beëindigen... "),
              PrivacyWidget(title: "10. Updates ", subTitle: "De Applicatie kan automatisch updates ontvangen om prestaties, veiligheid en functies te verbeteren... "),
              PrivacyWidget(title: "11. Toepasselijk Recht ", subTitle: "Op deze Voorwaarden is Nederlands recht van toepassing... "),
              PrivacyWidget(title: "12. Contact ", subTitle: "Heb je vragen of klachten? Neem contact op via: info@smileart.nl"),
           SizedBox(height:18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(onTap: () {},
                    buttonText: "Agree",
                    height: 38,
                    width: Get.width / 2.5,)
                ],),
              SizedBox(height: 18,)
            ],
          ),
        ),
      ),
    );
  }
}
