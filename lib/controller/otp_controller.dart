import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import '../auth_service.dart';
import '../binding/bottom_nav_binding.dart';
import '../binding/onboarding_binding.dart';
import '../generated/assets.dart';
import '../view/screens/bottom_bar/bottom_navbar.dart';
import '../view/screens/onboarding/onboarding.dart';
import '../view/widgets/custom_dialog.dart';

class OtpController extends GetxController {
  final String email;
  final String password;
  final String fullname;
  final pinController = TextEditingController();
  final authService = AuthService();
  var enteredOtp = ''.obs;
  var resendCooldown = 60.obs;
  var isLoading = false.obs;
  var isVerifying = false.obs;

  Timer? _timer;

  OtpController(this.email, this.fullname, this.password);

  @override
  void onInit() {
    sendOtp();
    super.onInit();
  }

  void sendOtp() async {
    try {
      isLoading.value = true;
      final sentOtp = await authService.sendEmail(email);

      if (sentOtp != null) {
        startResendTimer();
        CustomSnackbar.success(
          title: 'OTP Sent',
          message: 'Verification code has been sent to your email.',
        );
      } else {
        throw Exception('Failed to send OTP');
      }
    } catch (e) {
      print('Error sending OTP: $e');
     CustomSnackbar.error(
        title: 'Error',
        message: 'Failed to send OTP. Please check your internet connection and try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void verifyOtp() async {
    if (enteredOtp.value.length != 6) {
      CustomSnackbar.error(
        title: 'Invalid OTP',
        message: 'Please enter a 6-digit OTP.',
      );
      return;
    }

    try {
      isVerifying.value = true;

      // Database verification method instead of local comparison
      final otpData = await authService.verifyOtpFromDatabase(email, enteredOtp.value);

      if (otpData != null) {
        await signup();
        await authService.markOtpAsUsed(otpData ['id']);
        showCustomDialog(
            context: Get.context!,
            onTap: () async {
              authService.getUserProfile();
              final userId = authService.currentUser?.id;

              if (userId == null) {
                throw Exception("User not logged in after signup");
              }

              final alreadyOnboarded = await authService.hasCompletedOnboarding(userId);

              if(alreadyOnboarded){
                Get.offAll(()=> CustomBottomNavBar(), binding: BottomNavBinding());
              } else{

                Get.to(() =>
                  Onboarding(), binding: OnboardingBinding());
              }

            },
            title: "Verification Complete!",
            subtitle:
            "Your account has been successfully verified.",
            image: Assets.imagesVerified,
            confirmText: "Continue");
      } else {
        CustomSnackbar.error(
          title: 'Invalid OTP',
          message: 'The OTP you entered is incorrect or has expired. Please try again.',
        );
        pinController.clear();
        enteredOtp.value = '';
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      CustomSnackbar.error(
        title: 'Verification Error',
        message: 'Something went wrong during verification. Please try again.',
      );
    } finally {
      isVerifying.value = false;
    }
  }

  void startResendTimer() {
    resendCooldown.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCooldown.value == 0) {
        timer.cancel();
      } else {
        resendCooldown.value--;
      }
    });
  }

  void resendCode() {
    if (resendCooldown.value == 0 && !isLoading.value) {
      pinController.clear();
      enteredOtp.value = '';
      sendOtp();
    }
  }

  Future<String?> signup() async {

    try {
      final result = await authService.signup(email, password, fullname);

      if (result == null) {
        CustomSnackbar.success(
          title: "Success",
          message: "Account created successfully!",
        );
      } else {
        CustomSnackbar.error(
          title: "Signup Failed",
          message: result,
        );
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "Error",
        message: "Something went wrong. Please try again later.",
      );
    }
    return null;
  }



  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}

