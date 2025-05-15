import 'package:get/get.dart';
import 'package:smile_art/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ForgotPasswordController());
  }
}