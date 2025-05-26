import 'package:get/get.dart';
import 'package:smile_art/controller/edit_profile_controller.dart';

class EditProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>EditProfileController());
  }

}