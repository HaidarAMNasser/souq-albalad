import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/modules/ad-details/presentation/bloc/ad_detail_cubit.dart';
import 'package:souq_al_balad/modules/ad-details/presentation/widgets/image_slide_view.dart';
import 'package:souq_al_balad/modules/stores/presentation/screens/owner_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:souq_al_balad/modules/ad-details/presentation/widgets/build_table_info.dart';

class CarDetailsScreen extends StatefulWidget {
  final int id;
  const CarDetailsScreen({super.key, required this.id});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late final ProductDetailsCubit _productDetailsCubit;
  void _shareToWhatsApp() async {
    final message = AppLocalization.of(context).translate('share_ad_message');
    final url = 'https://wa.me/?text=${Uri.encodeComponent(message)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    // print("aaaaaaaaaaaaaaaaaa");
    // print(widget.id);
    // print("aaaaaaaaaaaaaaaaaa");
    // if (widget.id != 0) {
    //   print("hereeeeeeeeeeeeeeee");
    //   _productDetailsCubit = ProductDetailsCubit();
    //   _productDetailsCubit
    //       .fetchProductDetails(widget.id); // ← Pass the actual product ID
    // }
  }

  @override
  void dispose() {
    _productDetailsCubit.close(); // dispose cubit to avoid memory leaks
    super.dispose();
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
    return BlocProvider(
      create: (_) => ProductDetailsCubit()..fetchProductDetails(widget.id),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: AppColors.primary2,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              //_shareToWhatsApp,
              icon: SvgPicture.asset(
                ImagesApp.share,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
          return widget.id != 0
              ? state is ProductDetailsSuccess
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.productData.images.length != 0 &&
                                state.productData.images.isNotEmpty)
                              SwipeImageGallery(
                                  imageUrls: state.productData.images),
                            SizedBox(height: 12.h),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Icon(
                            //           Icons.location_pin,
                            //           size: 25.sp,
                            //           color: AppColors.primary2,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               state.productData.product
                            //                   .addressDetails,
                            //               // AppLocalization.of(
                            //               //   context,
                            //               // ).translate('location_city'),
                            //               style: TextStyle(
                            //                 fontSize: 20.sp,
                            //                 color: AppColors.orange,
                            //                 fontFamily: 'Montserrat',
                            //               ),
                            //             ),
                            //             // Text(
                            //             //   AppLocalization.of(
                            //             //     context,
                            //             //   ).translate('location_detail'),
                            //             //   style: TextStyle(
                            //             //     fontSize: 14.sp,
                            //             //     color: AppColors.grey700,
                            //             //     fontFamily: 'Montserrat',
                            //             //   ),
                            //             // ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     Text(
                            //     state.productData.product.price,
                            //       style: TextStyle(
                            //         fontSize: 16.sp,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.orange,
                            //         fontFamily: 'Montserrat',
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 25.sp,
                                        color: AppColors.primary2,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              state.productData.product
                                                  .addressDetails,
                                              // AppLocalization.of(
                                              //   context,
                                              // ).translate('location_city'),
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: AppColors.orange,
                                                fontFamily: 'Montserrat',
                                              ),
                                            ),
                                            // Text(
                                            //   AppLocalization.of(
                                            //     context,
                                            //   ).translate('location_detail'),
                                            //   style: TextStyle(
                                            //     fontSize: 14.sp,
                                            //     color: AppColors.grey700,
                                            //     fontFamily: 'Montserrat',
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  state.productData.product.price,
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
                              state.productData.product.title,
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
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
                                      side: BorderSide(
                                          color: AppColors.primary2, width: 2),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.chat,
                                      size: 18.sp,
                                      color: AppColors.primary2,
                                    ),
                                    label: Text(
                                      AppLocalization.of(context)
                                          .translate('chat_here'),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.primary2,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                BlocBuilder<ProductDetailsCubit,
                                    ProductDetailsState>(
                                  builder: (context, state) => IconButton(
                                    icon: Icon(
                                      (state is ProductDetailsSuccess)
                                          ? state.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border
                                          : Icons.favorite_border,
                                      size: 24.sp,
                                      color: AppColors.primary2,
                                    ),
                                    onPressed: () => context
                                        .read<ProductDetailsCubit>()
                                        .toggleFavorite(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                Text(
                                  "${AppLocalization.of(context).translate('publish_date')} :",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  "${state.productData.product.createdAt.year},"
                                  "${state.productData.product.createdAt.month.toString().padLeft(2, '0')},"
                                  "${state.productData.product.createdAt.day.toString().padLeft(2, '0')}",
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

                            buildProductDetailsTable(
                                context, state.productData),
                            SizedBox(height: 20.h),
                            // Text(
                            //   AppLocalization.of(context)
                            //       .translate('features_title'),
                            //   style: TextStyle(
                            //     fontSize: 16.sp,
                            //     fontFamily: 'Montserrat',
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            // // buildFeatures(context),
                            // SizedBox(height: 20.h),
                            // الوصف الكامل
                            // Container(
                            //   width: double.infinity,
                            //   padding: EdgeInsets.all(12.w),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(12.r),
                            //     border: Border.all(color: AppColors.primary2),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         AppLocalization.of(context)
                            //             .translate('description'),
                            //         style: TextStyle(
                            //           fontSize: 16.sp,
                            //           fontWeight: FontWeight.bold,
                            //           fontFamily: 'Montserrat',
                            //         ),
                            //       ),
                            //       SizedBox(height: 8.h),
                            //       Text(
                            //         state.productData.product.description,
                            //         style: TextStyle(
                            //           fontSize: 14.sp,
                            //           fontFamily: 'Montserrat',
                            //         ),
                            //         textDirection: TextDirection.rtl,
                            //       ),
                            //       SizedBox(height: 6.h),
                            //       Align(
                            //         alignment: Alignment.center,
                            //         child: TextButton(
                            //           onPressed: () {
                            //             setState(() {
                            //               isExpanded = !isExpanded;
                            //             });
                            //           },
                            //           style: ButtonStyle(
                            //             overlayColor: WidgetStateProperty.all(
                            //               Colors.transparent,
                            //             ),
                            //             splashFactory: NoSplash.splashFactory,
                            //           ),
                            //           child: Text(
                            //             isExpanded
                            //                 ? AppLocalization.of(
                            //                     context,
                            //                   ).translate('show_less')
                            //                 : AppLocalization.of(
                            //                     context,
                            //                   ).translate('show_more'),
                            //             style: TextStyle(
                            //               fontSize: 14.sp,
                            //               color: AppColors.orange,
                            //               fontFamily: 'Montserrat',
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Builder(builder: (context) {
                              // --- Logic to check for text overflow ---
                              final description =
                                  state.productData.product.description;
                              final style = TextStyle(
                                  fontSize: 14.sp, fontFamily: 'Montserrat');
                              const int maxLinesWhenCollapsed =
                                  4; // Max lines before "Show More" appears

                              // Calculate the available width for the text
                              final screenWidth =
                                  MediaQuery.of(context).size.width;
                              // Padding: 16 on each side for the screen, 12 on each side for the container
                              final textMaxWidth =
                                  screenWidth - (16.w * 2) - (12.w * 2);

                              // Use a TextPainter to determine if the text will exceed the max lines
                              final textPainter = TextPainter(
                                text: TextSpan(text: description, style: style),
                                maxLines: maxLinesWhenCollapsed,
                                textDirection: TextDirection.rtl,
                              )..layout(maxWidth: textMaxWidth);

                              final isTextOverflowing =
                                  textPainter.didExceedMaxLines;
                              // --- End of logic ---

                              return Container(
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
                                      AppLocalization.of(context)
                                          .translate('description'),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      description,
                                      style: style,
                                      maxLines: isExpanded
                                          ? null
                                          : maxLinesWhenCollapsed, // Dynamically set max lines
                                      overflow: TextOverflow
                                          .ellipsis, // Show '...' when collapsed
                                      textDirection: TextDirection.rtl,
                                    ),
                                    // *** Conditionally show the button ***
                                    if (isTextOverflowing)
                                      Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            splashFactory:
                                                NoSplash.splashFactory,
                                          ),
                                          child: Text(
                                            isExpanded
                                                ? AppLocalization.of(context)
                                                    .translate('show_less')
                                                : AppLocalization.of(context)
                                                    .translate('show_more'),
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
                              );
                            }),
                            SizedBox(height: 20.h),
                            // صاحب الإعلان
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdOwnerScreen(
                                          id: state
                                              .productData.product.addedBy)),
                                );
                              },
                              child: Container(
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
                                      AppLocalization.of(context)
                                          .translate('ad_owner'),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${state.productData.product.addedBy}" ??
                                                  "",
                                            ),
                                            Text(
                                              state.productData.product
                                                  .sellerPhone,
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
                                    AppLocalization.of(context)
                                        .translate('safety_tips'),
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
                                  AppLocalization.of(context)
                                      .translate('report_ad'),
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
                    )
                  : state is ProductDetailsLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : state is ProductDetailsFailure
                          ? Column(
                              children: [],
                            )
                          : Container()
              : Column(
                  children: [
                    Text(
                      "المنتج المحدد غير صالح",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }
}
