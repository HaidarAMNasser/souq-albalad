import 'package:cached_network_image/cached_network_image.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/product/models/location_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/home/view/screen/location_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchResultsByLocationScreen extends StatefulWidget {

  List<LocationModel> products;

  SearchResultsByLocationScreen({required this.products, super.key});

  @override
  State<SearchResultsByLocationScreen> createState() => _SearchResultsByLocationScreenState();
}

class _SearchResultsByLocationScreenState extends State<SearchResultsByLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(toolbarHeight: 70),
      body:
          widget.products.isEmpty
              ? Center(
                child: Text(
                  AppLocalization.of(context).translate("no_data_found"),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: widget.products.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
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
                                widget.products[index].title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              Text(
                                widget.products[index].type == "product" ||
                                        widget.products[index].type == "service"
                                    ? widget.products[index].price!
                                    : widget.products[index].salary!,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.orange,
                                ),
                              ),
                              Text(
                                widget.products[index].type == "product"
                                    ? widget.products[index].category!
                                    : widget.products[index].type == "job"
                                    ? widget.products[index].jobTitle!
                                    : widget.products[index].serviceType!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        // todo go to product details
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
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(child: InkWell(
                                    onTap: () {
                                      Get.to(
                                            () => LocationMapScreen(
                                          latitude:
                                          widget.products[index].latitude!,
                                          longitude:
                                          widget.products[index].longitude!,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: AppColors.primary2),
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalization.of(
                                            context,
                                          ).translate("location"),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.copyWith(
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 120.w,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CachedNetworkImage(
                              imageUrl: widget.products[index].image == null ? "" :
                              AppUrls.imageUrl + widget.products[index].image!.image!,
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
