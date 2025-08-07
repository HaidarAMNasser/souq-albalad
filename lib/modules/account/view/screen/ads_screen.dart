import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  List<Map<String, dynamic>> myAds = [
    {
      "name": "iPhone 13 Pro Max ",
      "image": "assets/images/ad.png",
      "price": "7,000,000",
    },
    {
      "name": "Canon 700D camera with 18-55mm lens",
      "image": "assets/images/ad.png",
      "price": "8,000,000",
    },
    {
      "name": "Wooden TV stand - modern design",
      "image": "assets/images/ad.png",
      "price": "12,000,000",
    },
    {"name": "LG 43 TV", "image": "assets/images/ad.png", "price": "9,000,000"},
    {"name": "LG 43 TV", "image": "assets/images/ad.png", "price": "9,000,000"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalization.of(context).translate("my_ads"),
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: myAds.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            padding: EdgeInsets.all(15.w),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myAds[index]["name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        myAds[index]["price"],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: AppColors.orange,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // todo edit ad
                            },
                            child: Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary2,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalization.of(context).translate("edit"),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.lightSurface,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          InkWell(
                            onTap: () => _showDeleteConfirmation(context),
                            child: Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.lightSurface,
                                border: Border.all(color: AppColors.error),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalization.of(
                                    context,
                                  ).translate("delete_ad"),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.error,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    myAds[index]["image"],
                    height: 120.w,
                    width: 100.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              AppLocalization.of(context).translate("are_you_sure"),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),

            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppLocalization.of(context).translate("delete"),
                    backgroundColor: Colors.transparent,
                    textColor: AppColors.error,
                    onPressed: () {
                      // TODO: delete ad API
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: AppLocalization.of(context).translate("cancel"),
                    backgroundColor: Colors.transparent,
                    textColor: Theme.of(context).colorScheme.onSurface,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
