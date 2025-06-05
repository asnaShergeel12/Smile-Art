import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_art/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constant/app_constants.dart';
import '../model/profile_model.dart';
import '../view/widgets/custom_snackbar.dart';

class EditProfileController extends GetxController {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final user = userModelGlobal.value;
  final RxString profilePic = ''.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final String fallbackImage =
      'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';

  final supabaseClient = Supabase.instance.client;
  final AuthService authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    fullNameController.text =
        '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
    emailController.text = user.email ?? '';
    profilePic.value = user.profilePicture.isNotEmpty ? user.profilePicture : fallbackImage;
  }

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        print("Picked image: ${pickedFile.path}");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      CustomSnackbar.error(title: "Error", message: "Failed to pick image: $e");
      print("Error picking image: $e");
    }
  }

  Future<String?> uploadImageToSupabase() async {
    if (selectedImage.value == null) {
      print("No image selected for upload.");
      return null;
    }

    try {
      final file = selectedImage.value!;
      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}';
      print("Uploading image: $fileName");

      final response = await supabaseClient.storage
          .from('profile-pictures')
          .upload(fileName, file);

      if (response.isEmpty) {
        CustomSnackbar.error(title: "Upload Failed", message: "Could not upload image.");
        print("Upload response is empty.");
        return null;
      }

      final publicUrl = supabaseClient.storage
          .from('profile-pictures')
          .getPublicUrl(fileName);
      print("Uploaded image URL: $publicUrl");

      // Update profile in database
      await authService.updateProfileField(fields: {
        'profile_picture': publicUrl
      });

      // Update the observable for profile picture
      profilePic.value = publicUrl;
      print("Profile Picture URL updated to: ${profilePic.value}");

      return publicUrl;
    } catch (e) {
      profilePic.value = fallbackImage;
      CustomSnackbar.error(title: "Error", message: "Image upload failed: $e");
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> updateUserProfile() async {
    final fullName = fullNameController.text.trim();
    final nameParts = fullName.split(' ');
    final updatedFirstName = nameParts.isNotEmpty ? nameParts.first : '';
    final updatedLastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    try {
      // Upload the image and update the profile picture URL
      await uploadImageToSupabase();
      print("Image uploaded and profile picture URL updated to: ${profilePic.value}");

      // Update the user's first and last name in the database
      await authService.updateProfileField(fields: {
        'first_name': updatedFirstName,
        'last_name': updatedLastName,
      });
      print("User  profile updated in database. ");
      CustomSnackbar.success(
        title: "Success",
        message: "Profile updated successfully.",
      );

      // Fetch the latest user data to ensure the local model is updated
      final user = supabaseClient.auth.currentUser ;
      if (user != null) {
        final latest = await supabaseClient
            .from('profile')
            .select()
            .eq('id', user.id)
            .maybeSingle();

        if (latest != null) {
          userModelGlobal.value = ProfileModel.fromJson(latest);
          userModelGlobal.refresh();
          print("User  model updated with latest data.");
        } else {
          print("No latest user data found.");
        }
      }
    } catch (e) {
      CustomSnackbar.error(
        title: "Error",
        message: "Failed to update profile. Please try again.",
      );
      print("Error updating user profile: $e");
    }
  }
}