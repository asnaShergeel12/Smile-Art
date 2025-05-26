// import 'package:get/get.dart';
// import '../auth_service.dart';
//
// class UserProfileController extends GetxController {
//   final fullname = ''.obs;
//   final email = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadUserProfile();
//   }
//
//   Future<void> loadUserProfile() async {
//     final data = await AuthService().getUserProfile();
//     fullname.value = data?['fullname'] ?? 'User';
//     email.value = data['email'] ?? 'No email';
//   }
// }
