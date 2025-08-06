import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/custom_table_widget.dart';
import 'package:souq_al_balad/global/components/description_box_widget.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/service/models/service_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:souq_al_balad/global/utils/convert_date.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/home/view/screen/location_map_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetailsScreen extends StatefulWidget {

  ServiceModel service;

  ServiceDetailsScreen({required this.service,super.key});

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetUserEvent(widget.service.addedBy!,context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                  items: widget.service.images!.map((i) {
                    return SizedBox(
                      height: 245.h,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: widget.service.images!.isEmpty ? "" :
                        AppUrls.imageUrl + i.image!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, child, loadingProgress) {
                          return const Center(child: AppLoader());
                        },
                        errorWidget: (context, error, stackTrace) {
                          return Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: Colors.grey[400],
                          );
                        },
                      ),
                    );
                  }).toList(),
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.service.images!.length,
                      (dotIndex) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: currentIndex == dotIndex ? 12.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color:
                      currentIndex == dotIndex ? AppColors.orange : AppColors.grey300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.service.title!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        Get.to(
                              () => LocationMapScreen(
                            latitude: widget.service.latitude!,
                            longitude: widget.service.longtitude!,
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_rounded,color: AppColors.primary2),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: Text("${widget.service.governorate!} - ${widget.service.location!}",
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w800,fontSize: 16,
                                  color: AppColors.primary2
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // todo go to chat screen
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(1.sw, 50.h),
                              side: BorderSide(color: AppColors.primary2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            icon: Icon(
                              Icons.chat,
                              size: 23,
                              color: AppColors.primary2,
                            ),
                            label: Text(
                              AppLocalization.of(context).translate('chat_here'),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final Uri launchUri = Uri(
                                scheme: 'tel',
                                path: widget.service.phoneNumber!,
                              );
                              if (await canLaunchUrl(launchUri)) {
                              await launchUrl(launchUri);
                              } else {
                              throw 'Could not launch $launchUri';
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(1.sw, 50.h),
                              backgroundColor : AppColors.primary2,
                              side: BorderSide(color: AppColors.primary2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            icon: Icon(
                              Icons.phone,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: Text(
                              widget.service.phoneNumber!,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${AppLocalization.of(context).translate('publish_date')}: ",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,fontSize: 10,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            convertDate(date: widget.service.createdAt!),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              CustomTableWidget(title: AppLocalization.of(context).translate("service_type"), subTitle: widget.service.type!),
              CustomTableWidget(title: AppLocalization.of(context).translate("price_if_any"),
                  subTitle: '${widget.service.costs?.firstWhere(
                    (cost) => cost.isMain == 1,
              ).costAfterChange} ${widget.service.costs?.firstWhere(
                    (cost) => cost.isMain == 1,
              ).fromCurrency}'),
              CustomTableWidget(title: AppLocalization.of(context).translate("working_days_hours"), subTitle: widget.service.daysHour!),
              CustomTableWidget(title: AppLocalization.of(context).translate("address"), subTitle: widget.service.location!),
              CustomTableWidget(title: AppLocalization.of(context).translate("email"), subTitle: widget.service.email!),
              SizedBox(height: 40.h),
              DescriptionBox(description: widget.service.description!),
              SizedBox(height: 40.h),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return state.getUserState == StateEnum.loading
                      ? Center(child: AppLoader(size: 25.w))
                      : InkWell(
                    onTap: () {
                      // todo go to ad owner screen
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.primary2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalization.of(context).translate("ad_owner"),
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 80.w,
                                  width: 80.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.r)
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.r),
                                    child: CachedNetworkImage(
                                      imageUrl: state.user!.logoPathFromServer == null ? "" :
                                      AppUrls.imageUrl + state.user!.logoPathFromServer!,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder: (context, child, loadingProgress) {
                                        return const Center(child: AppLoader());
                                      },
                                      errorWidget: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.image_not_supported,
                                          size: 40,
                                          color: Colors.grey[400],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15.w),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(state.user!.name!,
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Text(convertDate(date: state.user!.createdAt!),
                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }
}