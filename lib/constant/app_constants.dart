import 'package:get/get.dart';
import 'package:smile_art/model/profile_model.dart';

Rx<ProfileModel> userModelGlobal =
    ProfileModel(id: '', firstName: '', lastName: '', email: '').obs;
