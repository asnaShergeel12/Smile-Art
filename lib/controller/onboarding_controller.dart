import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/aligner_info_service.dart';
import 'package:smile_art/auth_service.dart';
import 'package:smile_art/binding/login_binding.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:smile_art/view/screens/bottom_bar/bottom_navbar.dart';
import '../constant/app_constants.dart';
import '../view/widgets/custom_snackbar.dart';

class OnboardingController extends GetxController {
  final currentPageIndex = 0.obs;
  late PageController pageController;
  final nameController = TextEditingController();
  final totalAlignerNumberController = TextEditingController();
  final currentAlignerNumberController = TextEditingController();
  final alignerWearDaysController = TextEditingController();
  final reminderController = TextEditingController();
  DateTime? selectedReminderTime;
  final user = userModelGlobal.value;
  AlignerInfoService alignerInfoService = AlignerInfoService();
  AuthService authService = AuthService();

  @override
  void onInit() {
    pageController = PageController();
    nameController.text =
        '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim() ?? '';
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
    await storeAlignerInfoToDatabase();
    Get.offAll(() => CustomBottomNavBar(),
        // binding: LoginBinding()
    );
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

  Future<void> storeAlignerInfoToDatabase() async {
    try {
      final result = await alignerInfoService.alignerInfo(
        totalAlignerNumberController.text,
        currentAlignerNumberController.text,
        alignerWearDaysController.text,
        selectedReminderTime!,
      );

      if (result == "Success") {
        CustomSnackbar.success(
          title: "Aligner info added",
          message: "Aligner Information added successfully!",
        );
      } else {
        CustomSnackbar.error(
          title: "Failed to store aligners information",
          message: result ?? "Unknown error occurred",
        );
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "Error",
        message: "Something went wrong. Please try again later.",
      );
    }
  }


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
