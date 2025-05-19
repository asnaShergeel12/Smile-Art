import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  final currentPageIndex = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void nextPage(List pagesList) {
    if (currentPageIndex.value < pagesList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void previousPage() {
    if (currentPageIndex.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Get.offAllNamed('/signup'); // Navigate to signup after onboarding
  }

  String get appBarText {
    switch (currentPageIndex.value) {
      case 0:
        return "Enter Name";
      case 1:
      case 2:
      case 3:
        return "About aligners";
      case 4:
        return "Enter Name";
      default:
        return "Onboarding";
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
