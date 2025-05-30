import 'package:get/get.dart';
import 'package:smile_art/controller/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as Map<String, dynamic>;
    final email = args['email'];
    final password = args['password'];
    final fullname = args['fullname'];
    Get.lazyPut(()=>OtpController(email, fullname, password));
  }
}