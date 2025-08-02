import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  List<Map<String, dynamic>> languagesList = [
    {"name": "العربية", "code": "ar"},
    {"name": "English", "code": "en"},
    // {"name":"Deutsch","code":"de"},
    // {"name":"Türkçe","code":"tr"},
  ];

  int selectLanguage = 0;

  @override
  void initState() {
    super.initState();
    selectLanguage = languagesList.indexWhere(
      (lang) => lang["code"] == CacheHelper.getData(key: HEADERLANGUAGEKEY),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalization.of(context).translate("language"),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: const Icon(Icons.arrow_back_outlined),
          ),
        ),
        foregroundColor: AppColors.primary2,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: languagesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectLanguage = index;
                      CacheHelper.changeLanguage(
                        context,
                        selectLanguage == 0 ? "ar" : "en",
                        /* selectLanguage == 1 ? "en" : selectLanguage == 2 ? "de" : "tr"*/
                      );
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          (isDark
                              ? AppColors.darkCardBackground
                              : AppColors.lightCardBackground),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          languagesList[index]["name"],
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
