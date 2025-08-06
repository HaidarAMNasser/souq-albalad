import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/offer/models/offer_model.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';

class OffersList extends StatefulWidget {

  final List<OfferModel> offers;

  const OffersList({required this.offers,super.key});

  @override
  State<OffersList> createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
      previous.searchOnProductsState != current.searchOnProductsState,
      builder: (context, state) {
        final isLoading = state.searchOnProductsState == StateEnum.loading;

        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 260.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.offers.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.offers[index].on!.type == "Category") {
                            BlocProvider.of<HomeBloc>(context).add(
                              SearchOnProductsEvent(
                                title: "",
                                inside: false,
                                categoryId: widget.offers[index].on!.data.id,
                                context: context,
                              ),
                            );
                          } else if (widget.offers[index].on!.type == "SubCategory") {
                            BlocProvider.of<HomeBloc>(context).add(
                              SearchOnProductsEvent(
                                title: "",
                                inside: false,
                                subCategoryId: widget.offers[index].on!.data.id,
                                context: context,
                              ),
                            );
                          } else {
                            // todo: go to product page
                          }
                        },
                        child: Container(
                          width: 180.w,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCardBackground : AppColors
                                .lightCardBackground,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180.w,
                                height: 120.h,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.offers[index].image != null && widget.offers[index].image!.isNotEmpty
                                        ? AppUrls.imageUrl + widget.offers[index].image!
                                        : "",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, child, loadingProgress) =>
                                    const Center(child: AppLoader()),
                                    errorWidget: (context, error, stackTrace) =>
                                        Icon(Icons.image_not_supported, size: 60,
                                            color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.offers[index].type == "discount" ? "${widget.offers[index].discount}%" :
                                      widget.offers[index].description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: isDark
                                            ? AppColors.darkTextPrimary
                                            : AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    if (widget.offers[index].type == "discount")
                                      Text(
                                        widget.offers[index].description ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: isDark
                                              ? AppColors.darkTextSecondary
                                              : AppColors.lightTextSecondary,
                                          height: 1.4,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: const Center(child: AppLoader(size: 20)),
                ),
              ),
          ],
        );
      },
    );
  }
}
