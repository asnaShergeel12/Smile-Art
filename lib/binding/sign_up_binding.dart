import 'package:get/get.dart';
import 'package:smile_art/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>SignUpController());
  }
}