import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/modules/favorites/bloc/favorite_bloc.dart';
import 'package:souq_al_balad/modules/favorites/bloc/favorite_events.dart';
import 'package:souq_al_balad/modules/favorites/bloc/favorite_states.dart';

class FavoritesScreen extends StatefulWidget {

  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc()..add(GetFavoritesEvent(context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: TextBoldApp(
            text: AppLocalization.of(context).translate("favorite"),
            sizeFont: 24,
            fontWeight: FontWeight.w900,
          ),
          foregroundColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {

              if(state.favoritesState == StateEnum.loading) {
                return Center(child: AppLoader());
              }

              if(state.favorites!.isEmpty) {
                return Center(child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(AppLocalization.of(context).translate("no_data_found"),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ));
              }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              itemCount: state.favorites!.length,
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
                              state.favorites![index].favorite!.title!,
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
                              '${state.favorites![index].favorite!.costs?.firstWhere(
                                    (cost) => cost.isMain == 1,
                              ).costAfterChange} ${state.favorites![index].favorite!.costs?.firstWhere(
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
                                SizedBox(width: 10.w),
                                BlocBuilder<FavoriteBloc, FavoriteState>(
                                    builder: (context, state) {
                                      if(state.deleteFromFavoriteState == StateEnum.loading &&
                                          state.deletingFavoriteId == state.favorites![index].favoriteId) {
                                        return SizedBox(width: 100.w,child: Center(child: AppLoader(size: 20)));
                                      }
                                      return InkWell(
                                        onTap: () {
                                          BlocProvider.of<FavoriteBloc>(context).add(
                                            DeleteFromFavoriteEvent(
                                              state.favorites![index].favoriteId!,
                                              context,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 100.w,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightSurface,
                                            border: Border.all(color: AppColors.primary2),
                                            borderRadius: BorderRadius.circular(10.r),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalization.of(
                                                context,
                                              ).translate("remove"),
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge!.copyWith(
                                                color: AppColors.primary2,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                  }
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
                            imageUrl: state.favorites![index].favorite!.images!.isEmpty ? "" :
                            AppUrls.imageUrl + state.favorites![index].favorite!.images!.first.image!,
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
        ),
      ),
    );
  }
}
