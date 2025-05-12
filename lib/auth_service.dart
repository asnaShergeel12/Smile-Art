import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();

  factory AuthService()=> _authService;

  AuthService._internal();

  final supabase = Supabase.instance.client;
  //signup
  Future<String?> signup(String email, String password) async {
    try{
      final response = await supabase.auth.signUp(
          password: password,
          email: email
      );
      if(response.user != null){
        return null;
      }
      return "An unknown error occurred";
  } on AuthException catch(e) {
      return e.message;
    } catch(e){
      return ("Error: $e");
  }
  }

  //login
  Future<String?> login(String email, String password) async {
    try{
      final response = await supabase.auth.signInWithPassword(
          email: email,
        password: password,

      );
      if(response.user != null){
        return null;
      }
      return "Invalid email or password";
    } on AuthException catch(e) {
      return e.message;
    } catch(e){
      return ("Error: $e");
    }
  }

  //logout
  Future<void> logout(BuildContext context)async{
    try{
      await supabase.auth.signOut();
      if(!context.mounted) return;
      Get.to(()=>Login());
    }
    catch(e){
      print("Logout error: $e");
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //     // Clearing any previous sign-in
  //     await googleSignIn.signOut();
  //
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) {
  //       throw Exception("Google Sign-In was cancelled");
  //     }
  //
  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final String? accessToken = googleAuth.accessToken;
  //     final String? idToken = googleAuth.idToken;
  //
  //     if (accessToken == null) {
  //       throw Exception("No Access Token found");
  //     }
  //     if (idToken == null) {
  //       throw Exception("No ID Token found");
  //     }
  //
  //     // Use Supabase to sign in with the Google tokens
  //     final AuthResponse response = await supabase.auth.signInWithIdToken(
  //       provider: OAuthProvider.google,
  //       idToken: idToken,
  //       accessToken: accessToken,
  //     );
  //
  //     if (response.user == null) {
  //       throw Exception("******************** Failed to sign in with Supabase ********************");
  //     }
  //
  //   } on AuthException catch (e) {
  //     print('******************** Supabase Auth Error: ${e.message} ********************');
  //     rethrow;
  //   } catch (e) {
  //     // Handle other errors
  //     print('******************** Google Sign-In Error: $e ********************');
  //     rethrow;
  //   }
  // }

  Future<void> signInWithGoogle() async {
    try {
      // For Android/iOS, no need for web client ID
      final GoogleSignIn googleSignIn = GoogleSignIn(
        // No clientId needed for mobile
        scopes: [
          'email',
          'profile',
        ],
      );

      // Ensure any previous sign-in is cleared
      await googleSignIn.signOut();

      // Trigger Google Sign-In
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw Exception("Google Sign-In was cancelled");
      }

      // Detailed authentication retrieval
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Extensive logging for debugging
      print('Google User Email: ${googleUser.email}');
      print('Google User ID: ${googleUser.id}');
      print('Access Token: ${googleAuth.accessToken}');
      print('ID Token: ${googleAuth.idToken}');

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

    } on PlatformException catch (e) {
      // Specific handling for platform-related errors
      print('Platform Error Details:');
      print('Error Code: ${e.code}');
      print('Error Message: ${e.message}');
      print('Error Details: ${e.details}');
      rethrow;
    } on AuthException catch (e) {
      // Supabase authentication specific errors
      print('Supabase Auth Error: ${e.message}');
      rethrow;
    } catch (e) {
      // Catch-all for any other unexpected errors
      print('Unexpected Google Sign-In Error: $e');
      rethrow;
    }
  }


}