import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';

class SellerProductsScreen extends StatefulWidget {

  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(GetSellerProductsEvent(context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            AppLocalization.of(context).translate("my_ads"),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
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
        body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if(state.sellerProductsState == StateEnum.loading) {
                return Center(child: AppLoader());
              }

              if(state.sellerProducts!.isEmpty) {
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
                itemCount: state.sellerProducts!.length,
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
                                state.sellerProducts![index].product!.title!,
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
                                '${state.sellerProducts![index].costs?.firstWhere(
                                      (cost) => cost.isMain == 1,
                                ).costAfterChange} ${state.sellerProducts![index].costs?.firstWhere(
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
                                      // todo edit ad
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
                                          AppLocalization.of(context).translate("edit"),
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
                                  InkWell(
                                    onTap: () {
                                      final blocContext = context;
                                      showDialog(
                                        context: blocContext,
                                        builder: (_) {
                                          return BlocProvider.value(
                                            value: BlocProvider.of<AccountBloc>(blocContext),
                                            child: AlertDialog(
                                              title: Text(
                                                AppLocalization.of(context).translate("are_you_sure"),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: 'Montserrat',
                                                ),
                                                textAlign: TextAlign.center,
                                              ),

                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: BlocBuilder<AccountBloc, AccountState>(
                                                        builder: (context, state) {
                                                          if(state.deleteSellerProductState == StateEnum.loading &&
                                                              state.productId == state.sellerProducts![index].product!.id!) {
                                                            return SizedBox(width: 100.w,height: 100.w,child: Center(child: AppLoader(size: 20)));
                                                          }
                                                          return CustomButton(
                                                            text: AppLocalization.of(context).translate("delete"),
                                                            backgroundColor: Colors.transparent,
                                                            textColor: AppColors.error,
                                                            onPressed: () {
                                                              BlocProvider.of<AccountBloc>(context).add(
                                                                DeleteSellerProductEvent(
                                                                  state.sellerProducts![index].product!.id!,
                                                                  context,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: CustomButton(
                                                      text: AppLocalization.of(context).translate("cancel"),
                                                      backgroundColor: Colors.transparent,
                                                      textColor: Theme.of(context).colorScheme.onSurface,
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 100.w,
                                      height: 40.h,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightSurface,
                                        border: Border.all(color: AppColors.error),
                                        borderRadius: BorderRadius.circular(10.r),
                                      ),
                                      child: Center(
                                        child: Text(
                                          AppLocalization.of(
                                            context,
                                          ).translate("delete_ad"),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge!.copyWith(
                                            color: AppColors.error,
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
                              imageUrl: state.sellerProducts![index].images!.isEmpty ? "" :
                              AppUrls.imageUrl + state.sellerProducts![index].images!.first,
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
