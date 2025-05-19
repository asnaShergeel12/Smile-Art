import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smile_art/binding/reset_password_binding.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:smile_art/view/screens/auth/reset_password.dart';
import 'package:smile_art/view/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();

  factory AuthService() => _authService;

  AuthService._internal();

  final supabase = Supabase.instance.client;

  //signup
  Future<String?> signup(String email, String password, String fullname) async {
    try {
      final response =
          await supabase.auth.signUp(password: password, email: email);

      final user = response.user;

      if (user == null) throw 'User signup failed';
      await supabase.from('profile').insert({
        'id': user.id,
        'fullname': fullname,
      });

      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return ("Error: $e");
    }
  }

  //login
  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
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

  //logout
  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Get.offAll(() => Login());
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
      await supabase.auth.resetPasswordForEmail(email, redirectTo: 'smileart://reset-password');
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

  Future<bool> updateNewPassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      CustomSnackbar.success(title: "Success", message: "Password has been updated successfully!");
      return true;
    } catch (e) {
      // log("THis was the exception while changing the password: $e");
      CustomSnackbar.error(title: "Error", message: "Something went wrong.\n $e");
      rethrow;
    }
  }
}
