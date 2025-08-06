import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:souq_al_balad/modules/account/view/screen/change_password_screen.dart';
import 'package:souq_al_balad/modules/account/view/screen/edit_seller_profile_screen.dart';
import 'package:souq_al_balad/modules/account/view/screen/edit_user_profile_screen.dart';
import 'package:souq_al_balad/modules/account/view/screen/seller_products_screen.dart';
import 'package:souq_al_balad/modules/account/view/screen/upgrade_to_merchant_screen.dart';
import 'package:souq_al_balad/modules/account/view/widget/seller_section_widget.dart';
import 'package:souq_al_balad/modules/account/view/widget/user_section_widget.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:souq_al_balad/modules/settings/view/screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/account_option_item.dart';

class AccountScreen extends StatefulWidget {

  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc()..add(GetUserProfileEvent(context)),
        ),
        if(CacheHelper.getData(key: accountType) != "customer")
          BlocProvider<AccountBloc>(
            create: (context) => AccountBloc()..add(GetSellerProfileEvent(context)),
          ),
      ],
      child:  BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              title: TextBoldApp(
                text: AppLocalization.of(context).translate("my_account"),
                sizeFont: 24,
                fontWeight: FontWeight.w900,
              ),
              foregroundColor: Colors.transparent,
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    Get.to(() => SettingsScreen());
                  },
                  child: const Icon(
                    Icons.settings,
                    size: 35,
                    color: AppColors.primary2,
                  ),
                ),
              ],
              actionsPadding: EdgeInsets.symmetric(horizontal: 20.w),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: CacheHelper.getData(key: accountType) == null ?
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 100.h),
                    Text(AppLocalization.of(context).translate("welcome_to_souq_al_balad"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 25.h),
                    CustomButton(
                      width: 1.sw * 0.5,
                        text: AppLocalization.of(context).translate("login"),
                        onPressed: () => Get.offAll(LoginScreen())
                    )
                  ],
                ),
              ) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  CacheHelper.getData(key: accountType) == "customer"
                      ? UserSectionWidget()
                      : SellerSectionWidget(),
                  SizedBox(height: 30.h),
                  CacheHelper.getData(key: accountType) == "customer"
                      ? const Center()
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBoldApp(
                            text: AppLocalization.of(context).translate("my_ads"),
                            sizeFont: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          SizedBox(height: 15.h),
                          AccountOptionItem(
                            text: AppLocalization.of(
                              context,
                            ).translate("view_all_ads"),
                            icon: null,
                            onTap: () {
                              Get.to(() => const SellerProductsScreen());
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                  TextBoldApp(
                    text: AppLocalization.of(context).translate("account_settings"),
                    sizeFont: 18,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(height: 15.h),
                  CacheHelper.getData(key: accountType) == "customer"
                      ? AccountOptionItem(
                        text: AppLocalization.of(
                          context,
                        ).translate("upgrade_to_merchant_account"),
                        icon: ImagesApp.upgrade,
                        iconColor: AppColors.orange,
                        onTap: () {
                          Get.to(const UpgradeToMerchantScreen());
                        },
                      )
                      : Center(),
                  // todo
                  // AccountOptionItem(
                  //   text: AppLocalization.of(context).translate("paid_offers"),
                  //   icon: ImagesApp.star,
                  //   iconColor: Colors.amber,
                  //   onTap: () {
                  //     // todo go to offers
                  //   },
                  // ),
                  AccountOptionItem(
                    text: AppLocalization.of(context).translate("edit_account"),
                    icon: ImagesApp.edit,
                    iconColor: AppColors.grey700,
                    onTap: () async {
                      final result = await Get.to(() => EditUserProfileScreen());
                      if (result == true) {
                        setState(() {
                          context.read<AccountBloc>().add(GetUserProfileEvent(context));
                        });
                      }
                    },
                  ),
                  CacheHelper.getData(key: accountType) == "customer" ? Center() :
                  AccountOptionItem(
                        text: AppLocalization.of(
                          context,
                        ).translate("edit_store_info"),
                        icon: ImagesApp.edit,
                        iconColor: AppColors.grey700,
                        onTap: () async {
                          final result = await Get.to(() => EditSellerProfileScreen());
                          if (result == true) {
                            setState(() {
                              context.read<AccountBloc>().add(GetSellerProfileEvent(context));
                            });
                          }
                        },
                      ),
                  AccountOptionItem(
                    text: AppLocalization.of(context).translate("change_password"),
                    icon: ImagesApp.lock,
                    iconColor: AppColors.grey700,
                    onTap: () {
                      Get.to(() => ChangePasswordScreen());
                    },
                  ),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      return state.logoutState == StateEnum.loading
                          ? Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Center(child: AppLoader(size: 25.w)),
                          )
                          : AccountOptionItem(
                            text: AppLocalization.of(context).translate("logout"),
                            icon: ImagesApp.logout,
                            iconColor: AppColors.error,
                            textColor: AppColors.error,
                            onTap: () async {
                              BlocProvider.of<AccountBloc>(
                                context,
                              ).add(LogoutEvent(context));
                            },
                          );
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
