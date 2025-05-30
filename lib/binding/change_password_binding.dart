import 'package:get/get.dart';
import 'package:smile_art/controller/change_password_controller.dart';

class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> ChangePasswordController());
  }
}