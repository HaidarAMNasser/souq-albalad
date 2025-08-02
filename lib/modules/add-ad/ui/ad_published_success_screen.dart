import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class AdPublishedSuccessScreen extends StatelessWidget {
  const AdPublishedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void shareToWhatsApp() async {
      final message = AppLocalization.of(context).translate("share_message");
      final url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch \$url');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.primary2,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 10.h),
              Icon(
                Icons.verified_rounded,
                size: 200.r,
                color: AppColors.primary2,
              ),
              SizedBox(height: 20.h),
              Text(
                AppLocalization.of(context).translate("ad_published_success"),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                AppLocalization.of(context).translate("ad_visible_to_visitors"),
                style: TextStyle(fontSize: 18.sp, fontFamily: 'Montserrat'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary2,
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 14.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        // Show Ad screen
                      },
                      child: Text(
                        AppLocalization.of(context).translate("view_ad"),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary2,
                        padding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 14.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        // Edit Ad screen
                      },
                      child: Text(
                        AppLocalization.of(context).translate("edit_ad"),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 0.85.sw,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary2, width: 2),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 14.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: shareToWhatsApp,
                  child: Text(
                    AppLocalization.of(context).translate("share_ad"),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary2,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 0.85.sw,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary2, width: 2),
                    padding: EdgeInsets.symmetric(
                      vertical: 14.h,
                      horizontal: 14.w,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Home page
                  },
                  child: Text(
                    AppLocalization.of(context).translate("back_to_home"),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary2,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
