import 'package:get/get.dart';
import 'package:smile_art/controller/bottom_nav_controller.dart';
import 'package:smile_art/controller/media_controller.dart';

class BottomNavBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>BottomNavController());
    Get.lazyPut(()=>MediaController());
  }
}