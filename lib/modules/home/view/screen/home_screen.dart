import 'package:souq_al_balad/global/components/custom_button_home.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/chat/chat_destinations/view/screen/chat_destinations_screen.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/home/view/widget/ad_card.dart';
import 'package:souq_al_balad/modules/home/view/widget/categories_loading.dart';
import 'package:souq_al_balad/modules/home/view/widget/featured_ads_slider.dart';
import 'package:souq_al_balad/modules/home/view/widget/featured_stores_slider.dart';
import 'package:souq_al_balad/modules/home/view/widget/grid_simple_categories_item.dart';
import 'package:souq_al_balad/modules/home/view/widget/home_appbar_app.dart';
import 'package:souq_al_balad/modules/home/view/widget/latest_products_grid.dart';
import 'package:souq_al_balad/modules/home/view/widget/list_story_circle_home.dart';
import 'package:souq_al_balad/modules/home/view/widget/special_offers_slider.dart';
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
      create: (context) => HomeBloc()
        ..add(GetCategoriesEvent(context))
        ..add(GetFeaturedProductsEvent(context))
        ..add(GetFeaturedStoreEvent(context))
        ..add(GetNewestProductsEvent(context)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
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
                    children: _items.asMap().entries.map((entry) {
                      return Container(
                        width: 8.w,
                        height: 8.w,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? AppColors.orange
                              : AppColors.lightBackground,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 25.h),
                  CustomButtonHome(
                    width: 280.w,
                    height: 45.h,
                    text: AppLocalization.of(context).translate("sections"),
                  ),
                  SizedBox(height: 10.h),
                  if (state.categoryState == StateEnum.loading)
                    CategoryShimmerGrid()
                  else
                    GridSimpleCategoriesItem(
                      categories: state.categories!,
                      count: state.categories!.length <= 3 ||
                              state.moreCategoriesClicked
                          ? state.categories!.length
                          : 3,
                    ),
                  SizedBox(height: 20.h),
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
                  if (state.featuredProductsState == StateEnum.loading ||
                      (state.featuredProducts != null &&
                          state.featuredProducts!.isNotEmpty))
                    CustomButtonHome(
                      width: 270.h,
                      height: 36.w,
                      text:
                          "${AppLocalization.of(context).translate("featured_ads")} ⭐",
                    ),
                  SizedBox(height: 20.h),
                  if (state.featuredProductsState == StateEnum.loading)
                    CategoryShimmerGrid()
                  else
                    FeaturedAdsSlider(products: state.featuredProducts!),
                  const SizedBox(height: 20),
                  if (state.featuredStoresState == StateEnum.loading ||
                      (state.featuredStores != null &&
                          state.featuredStores!.isNotEmpty))
                    CustomButtonHome(
                      width: 270.h,
                      height: 36.w,
                      text:
                          "${AppLocalization.of(context).translate("featured_stores")} 🏆",
                    ),
                  SizedBox(height: 20.h),
                  if (state.featuredStoresState == StateEnum.loading)
                    CategoryShimmerGrid()
                  else
                    FeaturedStoresSlider(stores: state.featuredStores!),
                  CustomButtonHome(
                    width: 270.h,
                    height: 36.w,
                    text:
                        "${AppLocalization.of(context).translate("special_offers")} 🔥",
                  ),
                  SizedBox(height: 20.h),
                  SpecialOffersSlider(),
                  SizedBox(height: 20.h),
                  if (state.newestProductsState == StateEnum.loading ||
                      (state.newestProducts != null &&
                          state.newestProducts!.isNotEmpty))
                    CustomButtonHome(
                      width: 270.h,
                      height: 36.w,
                      text: AppLocalization.of(context).translate("newest"),
                    ),
                  if (state.newestProductsState == StateEnum.loading)
                    CategoryShimmerGrid()
                  else
                    LatestProductsGrid(products: state.newestProducts!),
                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
