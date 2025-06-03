import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'auth_service.dart';
import 'view/screens/launch/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: 'https://rpgwozzciziciicrkica.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS'
          'IsInJlZiI6InJwZ3dvenpjaXppY2lpY3JraWNhIiwicm9sZSI6ImFub24iLCJpYX'
          'QiOjE3NDY2OTgxODEsImV4cCI6MjA2MjI3NDE4MX0.TV2RIqNHI9or3bX3iCSsCK'
          'yhqd4dT2wO8ObobZq6rv4'
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  AuthService().getUserProfile();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:"Manrope",
        useMaterial3: true,
        scaffoldBackgroundColor:kSecondaryColor
      ),
      home:const SplashScreen(),
    );
  }
}

