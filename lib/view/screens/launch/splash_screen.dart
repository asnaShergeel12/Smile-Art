import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_art/auth_service.dart';
import 'package:smile_art/binding/bottom_nav_binding.dart';
import 'package:smile_art/binding/onboarding_binding.dart';
import 'package:smile_art/view/screens/auth/login.dart';
import 'package:smile_art/view/screens/onboarding/onboarding.dart';
import 'package:smile_art/view/screens/start/start.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constant/app_colors.dart';
import '../../../generated/assets.dart';
import '../../widgets/common_image_widget.dart';
import '../bottom_bar/bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Use nullable types and initialize to null
  AnimationController? _animationController;
  Animation<Color?>? _backgroundColorAnimation;
  Animation<Color?>? _progressBarColorAnimation;
  Animation<double>? _progressAnimation;
  bool _showWhiteLogo = false;
  bool _isDisposed = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    // Delay the initialization slightly to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_isDisposed) return;
      _initAnimations();
    });
  }

  void _initAnimations() {
    if (_isDisposed) return;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Progress animation: 0 to 1 over 4 seconds
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController!);

    // Background animation: white to blue starting at halfway point
    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: kPrimaryColor,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.5, 1.0),
      ),
    );

    // Progress bar color animation: blue to white starting at halfway point
    _progressBarColorAnimation = ColorTween(
      begin: kPrimaryColor,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: const Interval(0.5, 1.0),
      ),
    );

    // Add listener to check progress and switch logo
    _animationController!.addListener(_onAnimationChanged);

    // Start the animation and navigate after completion
    if (!_isDisposed) {
      _animationController!.forward().then((_) async {
        if (_isDisposed) return;

        final supabase = Supabase.instance.client;
        final session = supabase.auth.currentSession;

        if (session != null) {
          try {
            // await supabase.auth.refreshSession();
            final prefs = await SharedPreferences.getInstance();
            final onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
            if (onboardingSeen) {
              // authService.getUserProfile();
              Get.offAll(() => CustomBottomNavBar(), binding: BottomNavBinding());
            } else {
              Get.offAll(()=> Onboarding(), binding: OnboardingBinding());
            }

          } catch (e) {
            debugPrint("Session error: $e");
            await supabase.auth.signOut();
            Get.offAll(() => const Start());
          }
        } else {
          Get.offAll(() => const Start());
        }
      });
    }
  }

  void _onAnimationChanged() {
    if (_isDisposed || _animationController == null) return;

    if (_animationController!.value >= 0.5 && !_showWhiteLogo) {
      if (mounted) {
        setState(() {
          _showWhiteLogo = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController?.removeListener(_onAnimationChanged);
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAnimatedContent(),
    );
  }

  Widget _buildAnimatedContent() {
    // If animations aren't initialized yet, show a loading state
    if (_animationController == null ||
        _backgroundColorAnimation == null ||
        _progressAnimation == null ||
        _progressBarColorAnimation == null) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(color:kPrimaryColor,),
        ),
      );
    }

    // Once animations are initialized, show the animated content
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        // Get safe color values with defaults
        final backgroundColor = _backgroundColorAnimation!.value ?? Colors.white;
        final progressColor = _progressBarColorAnimation!.value ?? kPrimaryColor;

        return Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Animate(
                effects: const [
                  FadeEffect(
                    duration: Duration(seconds: 2),
                  )
                ],
                child: CommonImageView(
                  imagePath: _showWhiteLogo
                      ? Assets.imagesLogoWhite
                      : Assets.imagesLogoPri,
                  height: 133,
                ),
              ),
              const SizedBox(height: 48),
              // Progress Bar
              SizedBox(
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), // Set the radius as needed
                  child: LinearProgressIndicator(
                    value: _progressAnimation!.value,
                    backgroundColor: kPrimaryColor.withOpacity(0.40),
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
              ),

            ],
          ),
        );
      },
    );
  }
}