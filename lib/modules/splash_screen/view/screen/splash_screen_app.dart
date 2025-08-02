import 'dart:async';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/navigation_bar/view/screen/main_layout_screen.dart';
import 'package:souq_al_balad/modules/onboarding/view/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreenApp extends StatefulWidget {
  const SplashScreenApp({super.key});

  @override
  State<SplashScreenApp> createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // إعداد الأنيميشن
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // بدء الأنيميشن
    _animationController.forward();

    // الانتقال بعد 3 ثوانٍ
    Timer(const Duration(seconds: 3), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    String? token = CacheHelper.getData(key: 'token');
    if (token == null) {
      Get.off(() => const OnboardingScreen());
    } else {
      Get.off(() => const MainLayoutScreen());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // مساحة مرنة في الأعلى
            const Spacer(flex: 2),

            // الشعار مع أنيميشن
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                ImagesApp.splashLogoApp,
                width: 302.w,
                height: 319.h,
                fit: BoxFit.cover,
              ),
            ),

            // مساحة مرنة في الأسفل
            const Spacer(flex: 2),

            // شريط التقدم
            Container(
              width: 0.6.sw,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 50.h),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF2E8B8B), // اللون الأساسي
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
