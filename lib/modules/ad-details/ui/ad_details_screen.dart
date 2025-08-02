import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/modules/ad-details/logic/car_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarDetailsScreen extends StatefulWidget {
  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  void _shareToWhatsApp() async {
    final message = AppLocalization.of(context).translate('share_ad_message');
    final url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  bool isExpanded = false;

  final List<Map<String, String>> reportReasons = [
    {
      "title": "محتوى غير لائق / مخالف",
      "description": "مثال: ألفاظ سيئة، صور غير مناسبة",
    },
    {
      "title": "معلومات مضللة / كاذبة",
      "description": "مثال: السعر غير حقيقي، وصف وهمي",
    },
    {"title": "إعلان مكرر / مزعج", "description": "نفس الإعلان منشور عدة مرات"},
    {"title": "تصنيف غير صحيح", "description": "الإعلان في قسم غير مناسب"},
  ];

  void _showReportModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalization.of(context).translate('report_reason_title'),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 12.h),
                ...reportReasons.map(
                  (reason) => Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.primary2),
                        ),
                        child: ListTile(
                          title: Text(
                            reason['title']!,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary2,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              reason['description']!,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            print("Selected reason: ${reason['title']}");
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const int trimLength = 80;
    final String fullText = AppLocalization.of(
      context,
    ).translate('car_description');
    final String displayText =
        isExpanded ? fullText : '${fullText.substring(0, trimLength)}...';

    return BlocProvider(
      create: (_) => CarDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            size: 24.sp,
            color: AppColors.primary2,
          ),
          actions: [
            IconButton(
              onPressed: _shareToWhatsApp,
              icon: SvgPicture.asset(
                ImagesApp.share,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.asset(
                      'assets/images/car.png',
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 25.sp,
                          color: AppColors.primary2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalization.of(
                                context,
                              ).translate('location_city'),
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: AppColors.orange,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            Text(
                              AppLocalization.of(
                                context,
                              ).translate('location_detail'),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.grey700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      AppLocalization.of(context).translate('price'),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  AppLocalization.of(context).translate('car_title'),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(Uri.parse("tel:0933446163"));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary2,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.call,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                        label: Text(
                          AppLocalization.of(
                            context,
                          ).translate('contact_phone'),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary2, width: 2),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.chat,
                          size: 18.sp,
                          color: AppColors.primary2,
                        ),
                        label: Text(
                          AppLocalization.of(context).translate('chat_here'),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary2,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    BlocBuilder<CarDetailsCubit, bool>(
                      builder:
                          (context, isFav) => IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 24.sp,
                              color: AppColors.primary2,
                            ),
                            onPressed:
                                () =>
                                    context
                                        .read<CarDetailsCubit>()
                                        .toggleFavorite(),
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(
                      AppLocalization.of(context).translate('publish_date'),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "04/02/2025",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(width: 40.w),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.primary2,
                      size: 20.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "124",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildInfoTable(),
                SizedBox(height: 20.h),
                Text(
                  AppLocalization.of(context).translate('features_title'),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                _buildFeatures(),
                SizedBox(height: 20.h),
                // الوصف الكامل
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primary2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).translate('description'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        displayText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 6.h),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          style: ButtonStyle(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(
                            isExpanded
                                ? AppLocalization.of(
                                  context,
                                ).translate('show_less')
                                : AppLocalization.of(
                                  context,
                                ).translate('show_more'),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.orange,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // صاحب الإعلان
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).translate('ad_owner'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              Icons.person,
                              size: 40.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalization.of(
                                  context,
                                ).translate('owner_name'),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                              Text(
                                "0900000000",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // نصائح الأمان
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primary2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalization.of(context).translate('safety_tips'),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppLocalization.of(
                          context,
                        ).translate('tip_check_product'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        AppLocalization.of(
                          context,
                        ).translate('tip_no_advance_payment'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        AppLocalization.of(
                          context,
                        ).translate('tip_meet_public'),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: OutlinedButton(
                    onPressed: () => _showReportModal(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primary2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      AppLocalization.of(context).translate('report_ad'),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.error,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTable() {
    Map<String, String> info = {
      AppLocalization.of(context).translate("condition"): AppLocalization.of(
        context,
      ).translate("used"),
      AppLocalization.of(context).translate("brand"): "مرسيدس بنز",
      AppLocalization.of(context).translate("model"): "C 200",
      AppLocalization.of(context).translate("year"): "2020",
      AppLocalization.of(context).translate("mileage"): "45,000 كم",
      AppLocalization.of(context).translate("transmission"): AppLocalization.of(
        context,
      ).translate("automatic"),
      AppLocalization.of(context).translate("engine_size"): "1.5 لتر",
      AppLocalization.of(context).translate("color"): AppLocalization.of(
        context,
      ).translate("black"),
      AppLocalization.of(context).translate("doors"): "5/6",
      AppLocalization.of(context).translate(
        "body_condition",
      ): AppLocalization.of(context).translate("no_accidents"),
      AppLocalization.of(context).translate("price_status"): AppLocalization.of(
        context,
      ).translate("negotiable"),
      AppLocalization.of(context).translate("email"): "example@email.com",
    };

    return Table(
      columnWidths: {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
      children:
          info.entries.map((e) {
            return TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    e.key,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(
                    e.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildFeatures() {
    final features = [
      AppLocalization.of(context).translate("air_conditioning"),
      AppLocalization.of(context).translate("parking_assist"),
      AppLocalization.of(context).translate("leather_handles"),
      AppLocalization.of(context).translate("heated_seats"),
      AppLocalization.of(context).translate("sunroof"),
      AppLocalization.of(context).translate("adaptive_cruise"),
    ];

    return Wrap(
      spacing: 10.w,
      runSpacing: 6.h,
      children:
          features.map((f) {
            return Chip(
              label: Text(
                f,
                style: TextStyle(fontSize: 12.sp, fontFamily: 'Montserrat'),
              ),
              avatar: Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 16.sp,
              ),
            );
          }).toList(),
    );
  }
}
