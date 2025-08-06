import 'package:cached_network_image/cached_network_image.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:flutter/material.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerSectionWidget extends StatelessWidget {

  const SellerSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return  (state.sellerProfileState == StateEnum.loading)
            ? Center(child: AppLoader(size: 20.w))
            : Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: 1.sw,
                  height: 250.h,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: CachedNetworkImage(
                      imageUrl: state.seller!.coverImage == null ? "" : AppUrls.imageUrl +
                          state.seller!.coverImage!,
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
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -40.h,
                  child: Container(
                            width: 125.w,
                            height: 125.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? Theme.of(context).scaffoldBackgroundColor : AppColors.lightCardBackground,
                              boxShadow: [
                                BoxShadow(
                                  color: isDark ? Colors.white.withOpacity(0.2) :
                                  Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(
                                  state.seller!.logo == null
                                      ? ""
                                      : AppUrls.imageUrl +
                                          state.seller!.logo!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                ),
              ],
            ),
            SizedBox(height: 60.h),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildColumnItem(
                      AppLocalization.of(context).translate("messages"),
                      "101",
                      context,
                    ),
                    verticalDivider(),
                    buildColumnItem(
                      AppLocalization.of(context).translate("active_ads"),
                      "101",
                      context,
                    ),
                    verticalDivider(),
                    buildColumnItem(
                      AppLocalization.of(context).translate("views"),
                      "101",
                      context,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildColumnItem(String title, String value, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 15.h),
          Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: AppColors.orange),
          ),
        ],
      ),
    );
  }

  Widget verticalDivider() {
    return VerticalDivider(color: Colors.grey[300], thickness: 1, width: 20);
  }
}
