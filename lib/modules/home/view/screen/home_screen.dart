import 'package:souq_al_balad/global/components/custom_button_home.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/home/view/widget/ad_card.dart';
import 'package:souq_al_balad/modules/home/view/widget/categories_loading.dart';
import 'package:souq_al_balad/modules/home/view/widget/featured_ads_slider.dart';
import 'package:souq_al_balad/modules/home/view/widget/featured_stores_slider.dart';
import 'package:souq_al_balad/modules/home/view/widget/grid_simple_categories_item.dart';
import 'package:souq_al_balad/modules/home/view/widget/home_appbar_app.dart';
import 'package:souq_al_balad/modules/home/view/widget/jobs_list.dart';
import 'package:souq_al_balad/modules/home/view/widget/newest_ads_slider.dart';
import 'package:souq_al_balad/modules/home/view/widget/list_story_circle_home.dart';
import 'package:souq_al_balad/modules/home/view/widget/offers_list.dart';
import 'package:souq_al_balad/modules/home/view/widget/services_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Widget> _items = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // todo remove later and replace it from backend
    _items = [
      AdCard(
        imagePath: "assets/images/ad.png",
        title: AppLocalization.of(context).translate("book_your_ad"),
        subtitle: AppLocalization.of(context).translate("promote_your_product"),
        buttonText: AppLocalization.of(context).translate("contact_us"),
        onPressed: () {},
      ),
      AdCard(
        imagePath: "assets/images/ad.png",
        title: AppLocalization.of(context).translate("book_your_ad"),
        subtitle: AppLocalization.of(context).translate("promote_your_product"),
        buttonText: AppLocalization.of(context).translate("contact_us"),
        onPressed: () {},
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              HomeBloc()
                ..add(GetCategoriesEvent(context))
                ..add(GetFeaturedProductsEvent(context))
                ..add(GetFeaturedStoreEvent(context))
                ..add(GetNewestProductsEvent(context))
                ..add(GetOffersEvent(context))
                ..add(GetServicesEvent(context))
                ..add(GetJobsEvent(context)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body:  RefreshIndicator(
              onRefresh: () async {
                final bloc = BlocProvider.of<HomeBloc>(context);
                bloc
                  ..add(GetCategoriesEvent(context))
                  ..add(GetFeaturedProductsEvent(context))
                  ..add(GetFeaturedStoreEvent(context))
                  ..add(GetNewestProductsEvent(context))
                  ..add(GetOffersEvent(context))
                  ..add(GetServicesEvent(context))
                  ..add(GetJobsEvent(context));
              },
              child: SingleChildScrollView(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        const HomeAppBar(),
                        SizedBox(height: 20.h),
                        const ListStoryCircleHomeAlternative(),
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: CarouselSlider(
                            items: _items,
                            options: CarouselOptions(
                              height: 200.h,
                              viewportFraction: 1,
                              autoPlay: false, // todo later
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              _items.asMap().entries.map((entry) {
                                return Container(
                                  width: 8.w,
                                  height: 8.w,
                                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        _currentIndex == entry.key
                                            ? AppColors.orange
                                            : AppColors.lightBackground,
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(height: 30.h),
                        /// sections
                        CustomButtonHome(
                          width: 280.w,
                          height: 45.h,
                          text: AppLocalization.of(context).translate("sections"),
                        ),
                        SizedBox(height: 20.h),
                        if (state.categoryState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.categories!.isNotEmpty ? GridSimpleCategoriesItem(
                            categories: state.categories!,
                            count: state.categories!.length <= 3 ||
                                state.moreCategoriesClicked
                                ? state.categories!.length
                                : 3,
                          ): Center(),
                        SizedBox(height: 10.h),
                        if (state.categories != null &&
                            state.categories!.isNotEmpty &&
                            !state.moreCategoriesClicked &&
                            state.categories!.length >= 3)
                          InkWell(
                            onTap: () {
                              BlocProvider.of<HomeBloc>(
                                context,
                              ).add(GetMoreCategoriesEvent(context));
                            },
                            child: TextBoldApp(
                              text:
                                  '${AppLocalization.of(context).translate("more")} ......',
                              sizeFont: 18,
                            ),
                          ),
                        SizedBox(height: 20.h),

                        /// services
                        if (state.servicesState == StateEnum.loading ||
                            (state.services != null &&
                                state.services!.isNotEmpty))
                          CustomButtonHome(
                            width: 280.w,
                            height: 45.h,
                            text: "${AppLocalization.of(context).translate("services")} ⭐",
                          ),
                        SizedBox(height: 20.h),
                        if (state.servicesState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.services!.isNotEmpty ? ServicesList(services: state.services!) : Center(),

                        /// jobs
                        if (state.jobsState == StateEnum.loading ||
                            (state.jobs != null &&
                                state.jobs!.isNotEmpty))
                          CustomButtonHome(
                            width: 280.w,
                            height: 45.h,
                            text: "${AppLocalization.of(context).translate("jobs")} ⭐",
                          ),
                        SizedBox(height: 20.h),
                        if (state.jobsState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.jobs!.isNotEmpty ? JobsList(jobs: state.jobs!) : Center(),

                        /// featured Products
                        if (state.featuredProductsState == StateEnum.loading ||
                            (state.featuredProducts != null &&
                                state.featuredProducts!.isNotEmpty))
                          CustomButtonHome(
                            width: 280.w,
                            height: 45.h,
                            text: "${AppLocalization.of(context).translate("featured_ads")} ⭐",
                          ),
                        SizedBox(height: 20.h),
                        if (state.featuredProductsState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.featuredProducts!.isNotEmpty ? FeaturedAdsSlider(products: state.featuredProducts!) : Center(),

                        /// stores
                        if (state.featuredStoresState == StateEnum.loading ||
                            (state.featuredStores != null &&
                                state.featuredStores!.isNotEmpty))
                          CustomButtonHome(
                            width: 280.w,
                            height: 45.h,
                            text: "${AppLocalization.of(context).translate("featured_stores")} 🏆",
                          ),
                        SizedBox(height: 20.h),
                        if (state.featuredStoresState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.featuredStores!.isNotEmpty ? FeaturedStoresSlider(stores: state.featuredStores!) : Center(),

                        /// special offers
                        if (state.offersState == StateEnum.loading ||
                            (state.offers != null &&
                                state.offers!.isNotEmpty))
                        CustomButtonHome(
                          width: 280.w,
                          height: 45.h,
                          text: "${AppLocalization.of(context).translate("special_offers")} 🔥",
                        ),
                        SizedBox(height: 20.h),
                        if (state.offersState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                         state.offers!.isNotEmpty ? OffersList(offers: state.offers!) : Center(),

                        /// newest Products
                        if (state.newestProductsState == StateEnum.loading ||
                            (state.newestProducts != null &&
                                state.newestProducts!.isNotEmpty))
                          CustomButtonHome(
                            width: 280.w,
                            height: 45.h,
                            text: AppLocalization.of(context).translate("newest"),
                          ),
                        SizedBox(height: 20.h),
                        if (state.newestProductsState == StateEnum.loading)
                          CategoryShimmerGrid()
                        else
                          state.newestProducts!.isNotEmpty ? NewestAdsSlider(products: state.newestProducts!) : Center(),

                        SizedBox(height: 40.h),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
