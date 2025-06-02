import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import '../auth_service.dart';
import '../binding/login_binding.dart';
import '../binding/onboarding_binding.dart';
import '../generated/assets.dart';
import '../view/screens/auth/login.dart';
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
              // Get.offAll(() => Login(), binding: LoginBinding());
              final seenOnboarding =
              await hasSeenOnboarding();
              if (seenOnboarding) {
                Get.offAll(() => const CustomBottomNavBar());
              } else {
                Get.offAll(() =>
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

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingSeen') ?? false;
  }

  Future<void> markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
  }

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }
}

