import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_bloc.dart';
import 'package:souq_al_balad/modules/sections/bloc/categories_events.dart' as categoryEvent;
import 'package:souq_al_balad/modules/sections/bloc/categories_states.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_bloc.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_events.dart'as subCategoryEvent;
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_states.dart';

class SearchResultsScreen extends StatefulWidget {

  String title;

  SearchResultsScreen({required this.title,super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {

  int? selectCategory;
  int? selectSubCategory;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  void clearData() {
    selectCategory = null;
    selectSubCategory = null;
    minPriceController.clear();
    maxPriceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 70,
          title: Text(widget.title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,fontWeight: FontWeight.w600
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 5.w),
          actions: [
            IconButton(
              icon: Row(
                children: [
                  const Icon(Icons.filter_list,color: Colors.white),
                  SizedBox(width: 5.w),
                  Text(AppLocalization.of(context).translate("filter"),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w800,fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              onPressed: () {
                clearData();
                _openFilterSheet(context);
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.searchOnProductsState == StateEnum.loading) {
                return const Center(child: AppLoader());
              }
              if (state.products!.isEmpty) {
                return Center(
                  child: Text(
                    AppLocalization.of(context).translate("no_data_found"),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                itemCount: state.products!.length,
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
                                state.products![index].product!.title!,
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
                                '${state.products![index].costs?.firstWhere(
                                      (cost) => cost.isMain == 1,
                                ).costAfterChange} ${state.products![index].costs?.firstWhere(
                                      (cost) => cost.isMain == 1,
                                ).fromCurrency}',
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
                              imageUrl: state.products![index].images!.isEmpty ? "" :
                              AppUrls.imageUrl + state.products![index].images!.first,
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
              );
            }
        )
    );
  }
  void _openFilterSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CategoriesBloc>(
              create: (context) => CategoriesBloc()..add(categoryEvent.GetCategoriesEvent(context)),
            ),
            BlocProvider.value(
              value: homeBloc,
            ),
          ],
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if(state.categoryState == StateEnum.loading) {
                  return Center(child: AppLoader(size: 20));
                }
                return BlocProvider(
                create: (context) {
                  final subCategoriesBloc = SubCategoriesBloc();
                  if (selectCategory != null) {
                    subCategoriesBloc.add(
                      subCategoryEvent.GetCategoriesEvent(
                        state.categories,
                        state.categories![selectCategory!].subCategories!,
                        selectCategory!,
                        context,
                      ),
                    );
                  }
                  return subCategoriesBloc;
                },
                child: BlocBuilder<SubCategoriesBloc, SubCategoriesState>(
                    builder: (context, subState) {
                    return DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.6,
                      maxChildSize: 0.9,
                      builder: (_, controller) {
                        return StatefulBuilder(
                            builder: (context, setModalState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: isDark ?  AppColors.darkCardBackground : AppColors.lightCardBackground,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
                              ),
                              padding: EdgeInsets.all(20.w),
                              child: ListView(
                                controller: controller,
                                children: [
                                  Center(
                                    child: Text(AppLocalization.of(context).translate("filter"),
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.w800,fontSize: 18
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  DropdownButton<int>(
                                    value: selectCategory,
                                    hint: Text(AppLocalization.of(context).translate("category")),
                                    isExpanded: true,
                                    items: List.generate(state.categories!.length, (index) {
                                      return DropdownMenuItem<int>(
                                        value: index,
                                        child: Text(state.categories![index].name!),
                                      );
                                    }),
                                    itemHeight: 70,
                                    onChanged: (int? newIndex) {
                                      if (newIndex == null) return;
                                      setModalState(() {
                                        selectCategory = newIndex;
                                        selectSubCategory = 0;
                                      });
                                      BlocProvider.of<SubCategoriesBloc>(context).add(
                                        subCategoryEvent.SetSubCategoriesEvent(
                                          state.categories![newIndex].subCategories,
                                          newIndex,
                                          context,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  if (subState.subCategories != null && subState.subCategories!.isNotEmpty) ...[
                                    DropdownButton<int>(
                                      value: selectSubCategory,
                                      hint: Text(AppLocalization.of(context).translate("sub_category")),
                                      isExpanded: true,
                                      items: List.generate(subState.subCategories!.length, (index) {
                                        return DropdownMenuItem<int>(
                                          value: index,
                                          child: Text(subState.subCategories![index].name!),
                                        );
                                      }),
                                      itemHeight: 70,
                                      onChanged: (int? newIndex) {
                                        if (newIndex == null) return;
                                        setModalState(() {
                                          selectSubCategory = newIndex;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                  SizedBox(height: (subState.subCategories != null && subState.subCategories!.isNotEmpty) ? 0 : 20.h),
                                  Row(
                                    children: [
                                      Expanded(child: CustomTextField(
                                        controller: minPriceController,
                                        hintText: AppLocalization.of(context).translate("min_price"),
                                        keyboardType: TextInputType.number,
                                      ),),
                                      SizedBox(width: 10.h),
                                      Expanded(child: CustomTextField(
                                        controller: maxPriceController,
                                        hintText: AppLocalization.of(context).translate("max_price"),
                                        keyboardType: TextInputType.number,
                                      ))
                                    ],
                                  ),
                                  SizedBox(height: 40.h),
                                  CustomButton(
                                      text: AppLocalization.of(context).translate("apply"),
                                      onPressed: () {
                                        BlocProvider.of<HomeBloc>(context).add(
                                          SearchOnProductsEvent(
                                            title: widget.title,
                                            categoryId: selectCategory != null ? state.categories![selectCategory!].id : null,
                                            subCategoryId: (selectCategory != null && selectSubCategory != null)
                                                ? state.categories![selectCategory!].subCategories![selectSubCategory!].id
                                                : null,
                                            minPrice: minPriceController.text == "" ? null : minPriceController.text,
                                            maxPrice: maxPriceController.text == "" ? null : maxPriceController.text,
                                            inside: true,
                                            context: context,
                                          ),
                                        );
                                      }
                                  )
                                ],
                              ),
                            );
                          }
                        );
                      },
                    );
                  }
                ),
              );
            }
          ),
        );
      },
    );
  }
}