import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/settings/view/screen/contact_support_screen.dart';
import 'package:souq_al_balad/modules/settings/view/screen/help_center_screen.dart';
import 'package:souq_al_balad/modules/settings/view/screen/languages_screen.dart';
import 'package:souq_al_balad/modules/settings/view/screen/privacy_policy_screen.dart';
import 'package:souq_al_balad/modules/settings/view/screen/terms_and_conditions_screen.dart';
import 'package:souq_al_balad/modules/settings/view/widget/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalization.of(context).translate("settings"),
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
            SizedBox(height: 20.h),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("dark_light_mode"),
              icon: ImagesApp.mode,
              isToggle: true,
              toggleWidget: GestureDetector(
                onTap: () {
                  setState(() {
                    CacheHelper().changeTheme(
                      isDark: !CacheHelper.getData(key: 'theme_mode') ?? false,
                    );
                  });
                },
                child: Icon(
                  (CacheHelper.getData(key: 'theme_mode') ?? false)
                      ? Icons.toggle_off
                      : Icons.toggle_on,
                  size: 30,
                ),
              ),
            ),
            SettingsItemWidget(
              text: AppLocalization.of(
                context,
              ).translate("manage_notifications"),
              icon: ImagesApp.notifications,
              isToggle: true,
              toggleWidget: GestureDetector(
                onTap: () {
                  setState(() {
                    // todo
                  });
                },
                child: Icon(Icons.toggle_off, size: 30),
              ),
            ),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("language"),
              icon: ImagesApp.language,
              onTap: () {
                Get.to(() => LanguagesScreen());
              },
            ),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("privacy_policy"),
              icon: ImagesApp.privacy,
              onTap: () {
                Get.to(() => PrivacyPolicyScreen());
              },
            ),
            SettingsItemWidget(
              text: AppLocalization.of(
                context,
              ).translate("terms_and_conditions"),
              icon: ImagesApp.terms,
              onTap: () {
                Get.to(() => TermsAndConditionsScreen());
              },
            ),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("help_center"),
              icon: ImagesApp.help,
              onTap: () {
                Get.to(() => HelpCenterScreen());
              },
            ),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("contact_support"),
              icon: ImagesApp.support,
              onTap: () {
                Get.to(() => ContactSupportScreen());
              },
            ),
            SettingsItemWidget(
              text: AppLocalization.of(context).translate("update_app"),
              icon: ImagesApp.update,
              onTap: () {
                // todo update a app
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
