import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/view/screens/onboarding/pages/aligner_number.dart';
import 'package:smile_art/view/screens/onboarding/pages/aligners.dart';
import 'package:smile_art/view/screens/onboarding/pages/change_aligner.dart';
import 'package:smile_art/view/screens/onboarding/pages/current_aligner.dart';
import 'package:smile_art/view/screens/onboarding/pages/name.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import '../../../controller/onboarding_controller.dart';
import '../../../generated/assets.dart';
import '../../widgets/my_text_widget.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});
  final onboardingController = Get.find<OnboardingController>();

  final List<Widget> pagesList = const [
    NamePage(),
    Aligners(),
    AlignerNumber(),
    ChangeAligner(),
    CurrentAligner(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: onboardingController.previousPage,
          icon: const Icon(Icons.arrow_back_ios_rounded, size: 16),
        ),
        title: Obx(() => MyText(
          text: onboardingController.appBarText,
          size: 16,
          weight: FontWeight.w500,
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Obx(() {
          final isLastPage =
              onboardingController.currentPageIndex.value ==
                  pagesList.length - 1;
          return MyButton(
            onTap: () => onboardingController.nextPage(pagesList),
            buttonText: isLastPage ? "Finish" : "Next",
          );
        }),
      ),
      body: Column(
        children: [
          const SizedBox(height: 18),
          CommonImageView(height: 64, imagePath: Assets.imagesPrimaryLogo),
          const SizedBox(height: 30),
          Expanded(
            child: PageView.builder(
              controller: onboardingController.pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: pagesList.length,
              onPageChanged: (index) {
                onboardingController.currentPageIndex.value = index;
              },
              itemBuilder: (_, i) => pagesList[i],
            ),
          ),
        ],
      ),
    );
  }
}

