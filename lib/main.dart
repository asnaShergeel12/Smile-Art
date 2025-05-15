import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/screens/auth/reset_password.dart';
import 'view/screens/launch/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://rpgwozzciziciicrkica.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS'
          'IsInJlZiI6InJwZ3dvenpjaXppY2lpY3JraWNhIiwicm9sZSI6ImFub24iLCJpYX'
          'QiOjE3NDY2OTgxODEsImV4cCI6MjA2MjI3NDE4MX0.TV2RIqNHI9or3bX3iCSsCK'
          'yhqd4dT2wO8ObobZq6rv4'
  );

  // Supabase.instance.client.auth.onAuthStateChange.listen((data) {
  //   final event = data.event;
  //   if (event == AuthChangeEvent.passwordRecovery) {
  //     // navigate to ResetPassword screen
  //     Get.to(() => ResetPassword());
  //   }
  // });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool hasSeenOnboarding = sharedPreferences.getBool('hasSeenOnboarding')?? false;

  runApp(MyApp(hasSeenOnboarding: hasSeenOnboarding));

}

class MyApp extends StatelessWidget {
  final bool hasSeenOnboarding;
  const MyApp({super.key, required this.hasSeenOnboarding});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:"Manrope",
        useMaterial3: true,
        scaffoldBackgroundColor:kSecondaryColor
      ),
      home:hasSeenOnboarding?
        const SplashScreen():const SplashScreen(),
    );
  }
}

