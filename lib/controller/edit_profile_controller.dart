import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_constants.dart';

class EditProfileController extends GetxController{
 final emailController = TextEditingController();
 final fullNameController = TextEditingController();
 final user = userModelGlobal.value;

 @override
  void onInit() {
    super.onInit();
    fullNameController.text =  '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim() ?? '';
    emailController.text = (user.email) ?? '';
  }

}