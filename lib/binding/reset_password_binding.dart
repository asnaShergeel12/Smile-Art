import 'package:get/get.dart';
import 'package:smile_art/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>ResetPasswordController());
  }
}