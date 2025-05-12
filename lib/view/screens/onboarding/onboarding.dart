import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/view/screens/auth/sign_up.dart';
import 'package:smile_art/view/screens/onboarding/pages/aligner_number.dart';
import 'package:smile_art/view/screens/onboarding/pages/aligners.dart';
import 'package:smile_art/view/screens/onboarding/pages/change_aligner.dart';
import 'package:smile_art/view/screens/onboarding/pages/current_aligner.dart';
import 'package:smile_art/view/screens/onboarding/pages/name.dart'; // Ensure this is the correct path
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_button.dart';

import '../../../generated/assets.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/my_text_widget.dart'; // Make sure this is the correct import for your custom appbar.

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // List of pages to show in the PageView.
  List<Widget> pagesList = [
    NamePage(),
    Aligners(),
    AlignerNumber(),
    ChangeAligner(),
    CurrentAligner()

  ];


  final PageController _pageController = PageController();


  int _currentPageIndex = 0;


  void _goToNextPage() {
    if (_currentPageIndex < pagesList.length - 1) {

      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {

      // Get.offAllNamed('/login'); // Replace '/login' with your desired screen
    }
  }


  void _goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to update the AppBar text based on the current page index.
  String _getAppBarText() {
    switch (_currentPageIndex) {
      case 0:
        return "Enter Name";
      case 1:
        return "About aligners";
      case 2:
        return "About aligners";
      case 3:
        return "About aligners";
      case 4:
        return "Enter Name";
      default:
        return "Onboarding";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _goToPreviousPage,
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 16,
          ),
        ),
        title: MyText(
          text: _getAppBarText(),
          size: 16,
          weight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 18),
          CommonImageView(
            height: 64,
            imagePath: Assets.imagesPrimaryLogo,
          ),
          SizedBox(height: 30),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              itemCount: pagesList.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, i) {
                return pagesList[i];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: MyButton(
              onTap: () {
                if (_currentPageIndex == pagesList.length - 1) {
                  // Navigate to the new screen
                  Get.to(() => SignUp());
                } else {
                  _goToNextPage();
                }
              },
              buttonText: _currentPageIndex == pagesList.length - 1
                  ? "Finish"
                  : "Next",
            ),
          ),

        ],
      ),
    );
  }
}
