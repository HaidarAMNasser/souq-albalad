import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/custom_button_home.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/category_model.dart';
import 'package:souq_al_balad/global/endpoints/categories/models/sub_category_model.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/modules/home/view/widget/grid_simple_sub_categories_item.dart';
import 'package:souq_al_balad/modules/home/view/widget/home_appbar_app.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_bloc.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_events.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/bloc/sub_categories_states.dart';
import 'package:souq_al_balad/modules/sections/sub_sections/view/widget/circular_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubsectionsScreen extends StatefulWidget {
  final List<SubCategoryModel>? subCategories;
  final List<CategoryModel>? categories;
  final int selectedCategoryIndex;

  const SubsectionsScreen({
    required this.subCategories,
    required this.categories,
    required this.selectedCategoryIndex,
    super.key,
  });

  @override
  State<SubsectionsScreen> createState() => _SubsectionsScreenState();
}

class _SubsectionsScreenState extends State<SubsectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SubCategoriesBloc()..add(
                GetCategoriesEvent(
                  widget.categories,
                  widget.subCategories,
                  widget.selectedCategoryIndex,
                  context,
                ),
              ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const HomeAppBar(viewTextSearch: false),
              SizedBox(height: 30.h),
              CustomButtonHome(
                width: 270.w,
                height: 36.h,
                text: AppLocalization.of(context).translate("sections"),
              ),
              SizedBox(height: 30.h),
              BlocBuilder<SubCategoriesBloc, SubCategoriesState>(
                builder: (context, state) {
                  if (state.subCategoryState == StateEnum.loading) {
                    return Center(child: AppLoader());
                  }
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 140.h,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CircularCategoryWidget(
                                    title:
                                        state.categories![index].name == null
                                            ? ""
                                            : state.categories![index].name!,
                                    imagePath:
                                        state.categories![index].image ?? '',
                                    isSelected: state.selectedIndex == index,
                                    onTap: () {
                                      BlocProvider.of<SubCategoriesBloc>(
                                        context,
                                      ).add(
                                        SetSubCategoriesEvent(
                                          state
                                              .categories![index]
                                              .subCategories,
                                          index,
                                          context,
                                        ),
                                      );
                                    },
                                    size: 100,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                  );
                                },
                                itemCount: state.categories!.length,
                              ),
                            ),
                            if (state.selectedIndex >= 0) ...[
                              SizedBox(height: 20.h),
                            ],
                          ],
                        ),
                      ),
                      GridSimpleSubCategoriesItem(
                        subCategories: state.subCategories!,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
