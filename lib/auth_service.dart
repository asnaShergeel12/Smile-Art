import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:math';
import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:smile_art/binding/login_binding.dart';
import 'package:smile_art/binding/reset_password_binding.dart';
import 'package:smile_art/constant/app_constants.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:smile_art/view/screens/auth/reset_password.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'model/otp_model.dart';
import 'model/profile_model.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();
  factory AuthService() => _authService;
  AuthService._internal();
  final supabase = Supabase.instance.client;

  Future<String?> signup(String email, String password, String fullname) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);

      final user = response.user;

      if (user == null) throw 'User signup failed';

      final nameParts = fullname.trim().split(RegExp(r"\s+"));
      final firstName = nameParts.isNotEmpty ? nameParts.first : '';
      final lastName =
          nameParts.isNotEmpty ? nameParts.sublist(1).join('') : '';
      // const deviceToke = '';

      ProfileModel userModel = ProfileModel(
          id: user.id,
          firstName: firstName,
          lastName: lastName,
          email: email);
      print('Attempting to insert user data: ${userModel.toJson()}');

      final insertUserData = await supabase.from('profile').insert(userModel.toJson()).select();
      print('User Data inserted successfully: $insertUserData');


      // await supabase.from('profile').insert({
      //   'id': user.id,
      //   'first_name': firstName,
      //   'last_name': lastName,
      //   'email': email,
      // });

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return ("Error: $e");
    }
  }

  int generateOtp() {
    final random = Random();
    return 100000 + random.nextInt(90000);
  }

  Future<String?> sendEmail(String email) async {
    try {
      var otp = generateOtp();
      DateTime createdAt = DateTime.now().toUtc();
      DateTime expiresAt = createdAt.add(const Duration(minutes: 1));

      // Create the OTP model
      OtpModel userOtp = OtpModel(
        email: email,
        otp: otp,
        createdAt: createdAt,
        expiringAt: expiresAt,
        isUsed: false,
      );

      print('Attempting to insert OTP: ${userOtp.toJson()}');

      // Insert new OTP record
      final insertResponse = await supabase
          .from('otp')
          .insert(userOtp.toJson())
          .select();

      print('OTP inserted successfully: $insertResponse');

      var serviceId = 'service_an5pgtn', templateId = 'template_krtrikb', userId = '8VlsjVOFc9poev_xv';

      final emailResponse = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'user_id': userId,
          'template_id': templateId,
          'template_params': {
            'passcode': otp.toString(),
            'sender_email': email,
            'time': DateFormat('yyyy-MM-dd HH:mm:ss').format(expiresAt.toLocal()),
          },
        }),
      );

      print('Email API Response Status: ${emailResponse.statusCode}');
      print('Email API Response Body: ${emailResponse.body}');

      if (emailResponse.statusCode == 200) {
        return otp.toString();
      } else {
        throw Exception('Email sending failed: ${emailResponse.statusCode} - ${emailResponse.body}');
      }

    } catch (e) {
      print('Error while sending email: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> verifyOtpFromDatabase(String email, String enteredOtp) async {
    try {
      final now = DateTime.now().toUtc();

      final response = await supabase
          .from('otp')
          .select()
          .eq('email', email)
          .eq('is_used', false)
          .gt('expiring_at', now.toIso8601String())
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response != null && response['otp'].toString() == enteredOtp.toString()) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return null;
    }
  }

  Future<void> markOtpAsUsed(String id) async {
    try {
      await supabase
          .from('otp')
          .update({'is_used': true})
          .eq('id', id);

      print('OTP marked as used for ID: $id');
    } catch (e) {
      print('Error in markOtpAsUsed: $e');
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      getUserProfile();
      if (response.user != null) {
        return null;
      }
      return "Invalid email or password";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return ("Error: $e");
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Get.offAll(() => Login(), binding: LoginBinding());
    } catch (e) {
      print("Logout error: $e");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // Web Client ID
      const webClientId =
          '734379831553-d4k2h8k9j46ohidavukr5sig85do71n3.apps.googleusercontent.com';
      const androidClientId =
          '734379831553-6kd1l8fv1l9ei2d6fnkc1p2g8adqb18v.apps.googleusercontent.com';
      const iosClientId =
          '734379831553-ve6gfg5don3jd0ae7aufr74ovq3fvr95.apps.googleusercontent.com';

      GoogleSignIn googleSignIn;

      // Platform-specific configuration
      if (GetPlatform.isAndroid) {
        googleSignIn = GoogleSignIn(
          serverClientId: webClientId,
          clientId: androidClientId,
          scopes: [
            'email',
            'profile',
            'openid',
          ],
        );
      } else if (GetPlatform.isIOS) {
        googleSignIn = GoogleSignIn(
          serverClientId: webClientId,
          clientId: iosClientId,
          scopes: [
            'email',
            'profile',
            'openid',
          ],
        );
      } else {
        throw UnsupportedError('Unsupported platform');
      }

      // Ensuring any previous sign-in is cleared
      await googleSignIn.signOut();

      // Triggering Google Sign-In
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Google Sign-In was cancelled");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      // Strict token validation
      if (accessToken == null) {
        throw Exception("Failed to obtain Access Token");
      }
      if (idToken == null) {
        throw Exception("Failed to obtain ID Token");
      }

      // Supabase sign-in with tokens
      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.user == null) {
        throw Exception("Supabase authentication failed");
      }
    } on TimeoutException catch (e) {
      print('Timeout Error: ${e.message}');
      rethrow;
    } on PlatformException catch (e) {
      print('Timeout Error: ${e.message}');
      rethrow;
    } on AuthException catch (e) {
      print('Supabase Auth Error: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected Google Sign-In Error: $e');
      rethrow;
    }
  }

  Future<void> resetPasswordViaEmailLink(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email,
          redirectTo: 'smileart://reset-password');
    } catch (e) {
      CustomSnackbar.error(
        title: "Error",
        message: 'Something went wrong.\n$e',
      );
    }
  }

  void configDeepLinkForResetPassword() {
    final appLinks = AppLinks();

    appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null && uri.host == 'reset-password') {
        Get.to(() => ResetPassword(), binding: ResetPasswordBinding());
      }
    });
  }

  Future<bool> updateNewForgottenPassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      CustomSnackbar.success(
          title: "Success", message: "Password has been updated successfully!");
      return true;
    } catch (e) {
      // log("THis was the exception while changing the password: $e");
      CustomSnackbar.error(
          title: "Error", message: "Something went wrong.\n $e");
      rethrow;
    }
  }

  getUserProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      supabase
          .from('profile')
          .stream(primaryKey: ['id'])
          .eq('id', user.id)
          .listen((value) {
            // log('This is user model $value');
            userModelGlobal.value = ProfileModel.fromJson(value.first);
          });
    } catch (e) {
      throw "Error fetching user profile: $e";
    }
    return null;
  }

  Future<void> updateProfileField({required Map<String, dynamic> fields}) async{
    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw "User not logged in";

      await supabase.from('profile').update(fields).eq('id', user.id);
      // refresh the user model globally
      await getUserProfile();

    } catch (e) {
      throw "Failed to update profile.\n$e" ;
    }
  }

  Future<String?> changePassword(String password) async {
    try{
      final response = await supabase.auth.updateUser(UserAttributes(password: password));
      if (response.user == null) {
        throw "Something went wrong" ;
      }

      return "Password updated successfully";
    } on AuthException catch(e){
      throw AuthException("Auth Error: ${e.message}");
    }
    catch(err){
      throw Exception("Unexpected Error: $err");

    }
  }

}
