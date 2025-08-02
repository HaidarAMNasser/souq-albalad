import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/onboarding/controller/onboarding_controller.dart';
import 'package:souq_al_balad/modules/onboarding/model/onboarding_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late OnboardingController controller;
  bool _showLanguages = false;
  int selectedLanguage = 0;

  List<Map<String, dynamic>> languagesList = [
    {"code": "ar"},
    {"code": "en"},
    // {"code":"tr"},
    // {"code":"de"},
  ];

  @override
  void initState() {
    super.initState();
    controller = OnboardingController();
    selectedLanguage = languagesList.indexWhere(
      (lang) => lang["code"] == CacheHelper.getData(key: HEADERLANGUAGEKEY),
    );
    print(selectedLanguage);
    // ✅ إضافة listener للتحديث التلقائي
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // الشعار في الأعلى
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 30.h),
              child: const LogoAppWidget(),
            ),

            // محتوى الصفحات
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.setCurrentIndex(index);
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(onboardingData[index], index);
                },
              ),
            ),

            // مؤشرات الصفحات والتنقل
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          // الصورة التوضيحية
          Expanded(
            flex: 3,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(data.image, fit: BoxFit.contain),
            ),
          ),

          // المحتوى النصي
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // العنوان
                TextBoldApp(
                  text: AppLocalization.of(context).translate(data.titleKey),
                  sizeFont: 24,
                  fontWeight: FontWeight.w800,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                // الوصفييي
                Text(
                  AppLocalization.of(context).translate(data.descriptionKey),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),

                // // اللغات في الصفحة الأخيرة
                // if (index == onboardingData.length - 1) ...[
                //   const SizedBox(height: 30),
                //   _buildLanguageSelection(),
                // ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelection() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _showLanguages = !_showLanguages;
            });
          },
          child: Icon(
            Icons.language,
            color: Theme.of(context).colorScheme.primary,
            size: 40,
          ),
        ),
        if (_showLanguages)
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: languagesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedLanguage = index;
                      CacheHelper.changeLanguage(
                        context,
                        selectedLanguage == 0 ? "ar" : "en",
                        /*selectedLanguage == 1 ? "en" : selectedLanguage == 2 ? "tr" : "de"*/
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          languagesList[index]["code"].toString().toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium!.copyWith(
                            fontSize: 14,
                            color:
                                selectedLanguage == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // مؤشرات الصفحات
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => _buildDot(index),
            ),
          ),

          SizedBox(height: 30.h),

          // أزرار التنقل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // زر السابق
              // اللغات في الصفحة الأخيرة
              controller.currentIndex == 0
                  ? _buildLanguageSelection()
                  : GestureDetector(
                    onTap:
                        controller.currentIndex > 0
                            ? controller.previousPage
                            : null,
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color:
                            controller.currentIndex > 0
                                ? const Color(0xFF2E8B8B)
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color:
                            controller.currentIndex > 0
                                ? Colors.white
                                : Colors.grey[500],
                      ),
                    ),
                  ),

              // زر التالي أو البدء
              GestureDetector(
                onTap: () {
                  if (controller.currentIndex == onboardingData.length - 1) {
                    // ✅ استخدم دالة الكنترولر
                    controller.completeOnboarding();
                  } else {
                    _showLanguages = false;
                    controller.nextPage();
                  }
                },
                child: Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E8B8B),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Icon(
                    controller.currentIndex == onboardingData.length - 1
                        ? Icons.check
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: controller.currentIndex == index ? 24 : 8,
      height: 8.h,
      decoration: BoxDecoration(
        color:
            controller.currentIndex == index
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}
