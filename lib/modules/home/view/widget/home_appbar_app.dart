import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/home/bloc/home_bloc.dart';
import 'package:souq_al_balad/modules/home/bloc/home_events.dart';
import 'package:souq_al_balad/modules/home/bloc/home_states.dart';
import 'package:souq_al_balad/modules/home/view/screen/search_by_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../global/utils/images_file.dart';

class HomeAppBar extends StatelessWidget {

  final VoidCallback? onMessages;
  final VoidCallback? onNotifications;
  final bool viewTextSearch;
  final TextEditingController? searchController;

  const HomeAppBar({
    super.key,
    this.onMessages,
    this.onNotifications,
    this.viewTextSearch = true,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.primary2),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            children: [
              LogoAppWidget(imagePath: ImagesApp.logoSouqSmLitht),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onNotifications ?? () {},
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  viewTextSearch == true
                      ? Expanded(child: _buildSearchField(context))
                      : Container(),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: onMessages ?? () {},
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
            return TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: searchController,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.darkBackground),
              decoration: InputDecoration(
                hintText: AppLocalization.of(
                  context,
                ).translate("search_for_any_product"),
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppColors.darkBackground),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: (state.searchOnProductsState == StateEnum.loading) ?
                    AppLoader(size: 15) :
                Icon(
                  Icons.search,
                  color: AppColors.darkBackground,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                suffixIcon: IconButton(
                  onPressed: () => Get.to(() => const SearchByLocationScreen()),
                  icon: Icon(Icons.location_on, color: Color(0xFF008081), size: 20),
                ),
              ),
              onSubmitted: (value) {
                BlocProvider.of<HomeBloc>(context).add(
                  SearchOnProductsEvent(
                    title: value,
                    inside: false,
                    context: context,
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
