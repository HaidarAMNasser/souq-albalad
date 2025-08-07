import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> myFavoritesList = [
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
        title: TextBoldApp(
          text: AppLocalization.of(context).translate("favorite"),
          sizeFont: 24,
          fontWeight: FontWeight.w900,
        ),
        foregroundColor: Colors.transparent,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: myFavoritesList.length,
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
                        myFavoritesList[index]["name"],
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
                        myFavoritesList[index]["price"],
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
                              // todo go to ad details screen
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
                                  AppLocalization.of(
                                    context,
                                  ).translate("details"),
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
                            onTap: () {
                              // TODO: remove API
                            },
                            child: Container(
                              width: 100.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: AppColors.lightSurface,
                                border: Border.all(color: AppColors.primary2),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalization.of(
                                    context,
                                  ).translate("remove"),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primary2,
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
                    myFavoritesList[index]["image"],
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
}
