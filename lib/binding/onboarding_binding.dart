import 'package:get/get.dart';
import 'package:smile_art/controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>OnboardingController());
  }
}