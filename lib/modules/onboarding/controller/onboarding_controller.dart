import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:souq_al_balad/modules/onboarding/model/onboarding_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends ChangeNotifier {
  late PageController pageController;
  int _currentIndex = 0;

  // Getters
  int get currentIndex => _currentIndex;
  bool get isFirstPage => _currentIndex == 0;
  bool get isLastPage => _currentIndex == onboardingData.length - 1;

  OnboardingController() {
    pageController = PageController();
  }

  // تغيير الصفحة الحالية
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // الانتقال للصفحة التالية
  void nextPage() {
    if (!isLastPage) {
      _currentIndex++;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // الانتقال للصفحة السابقة
  void previousPage() {
    if (!isFirstPage) {
      _currentIndex--;
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // الانتقال لصفحة محددة
  void goToPage(int index) {
    if (index >= 0 && index < onboardingData.length) {
      _currentIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  // إنهاء التوجيه والانتقال للتطبيق
  void completeOnboarding() {
    Get.off(() => const LoginScreen());
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

// بيانات صفحة التوجيه
final List<OnboardingData> onboardingData = [
  OnboardingData(
    image: ImagesApp.on3,
    titleKey: 'title_on3',
    descriptionKey: 'description_on2',
  ),
  OnboardingData(
    image: ImagesApp.on2,
    titleKey: 'title_on2',
    descriptionKey: 'description_on3',
  ),
  OnboardingData(
    image: ImagesApp.on1,
    titleKey: 'title_on1',
    descriptionKey: 'description_on1',
  ),
];
