import 'dart:io';
import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/image_pick.dart';
import 'package:souq_al_balad/global/components/show_dialog_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditSellerProfileScreen extends StatefulWidget {

  const EditSellerProfileScreen({super.key});

  @override
  State<EditSellerProfileScreen> createState() =>
      _EditSellerProfileScreenState();
}

class _EditSellerProfileScreenState extends State<EditSellerProfileScreen> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;
  XFile? coverImage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => AccountBloc()..add(GetSellerProfileEvent(context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            AppLocalization.of(context).translate("edit_store_info"),
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
            if (state.sellerProfileState == StateEnum.Success) {
              final seller = state.seller!;
              ownerNameController.text = seller.storeOwnerName ?? '';
              storeNameController.text = seller.storeName ?? '';
              addressController.text = seller.address ?? '';
              descriptionController.text = seller.description ?? '';
            }

            if (state.sellerProfileState == StateEnum.loading) {
              return Center(child: AppLoader(size: 30.w));
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                if (state.seller!.coverImage != null ||
                                    coverImage != null) {
                                  showAnimatedDialog(
                                    context,
                                    Center(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          width: 1.sw,
                                          height: 300.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                              coverImage != null
                                                  ? FileImage(
                                                File(coverImage!.path),
                                              )
                                                  : NetworkImage(
                                                AppUrls.imageUrl +
                                                    state
                                                        .seller!
                                                        .coverImage!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    dismissible: true,
                                  );
                                }
                              },
                              child: Container(
                                width: 1.sw,
                                height: 250.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
                                  image: DecorationImage(
                                    image: coverImage != null
                                        ? FileImage(File(coverImage!.path))
                                        : NetworkImage(
                                      state.seller!.coverImage == null
                                          ? ""
                                          : AppUrls.imageUrl +
                                          state.seller!.coverImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  showImageBottomSheet(
                                    context,
                                        () async {
                                      Navigator.pop(context);
                                      coverImage = await ImagePicker().pickImage(
                                        source: ImageSource.camera,
                                      );
                                      if (coverImage != null) {
                                        BlocProvider.of<AccountBloc>(
                                          context,
                                        ).add(SetImage(coverImage!));
                                      }
                                    },
                                        () async {
                                      Navigator.pop(context);
                                      coverImage = await ImagePicker().pickImage(
                                        source: ImageSource.gallery,
                                      );
                                      if (coverImage != null) {
                                        BlocProvider.of<AccountBloc>(
                                          context,
                                        ).add(SetImage(coverImage!));
                                      }
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.darkTextSecondary,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.r)
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(child: Icon(Icons.edit,
                                    color: isDark ? AppColors.lightCardBackground : AppColors.darkBackground,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: -40.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (state.seller!.logo != null ||
                                      image != null) {
                                    showAnimatedDialog(
                                      context,
                                      Center(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            width: 1.sw,
                                            height: 300.h,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    image != null
                                                        ? FileImage(
                                                          File(image!.path),
                                                        )
                                                        : NetworkImage(
                                                          AppUrls.imageUrl +
                                                              state
                                                                  .seller!
                                                                  .logo!,
                                                        ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      dismissible: true,
                                    );
                                  }
                                },
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
                                      image:
                                          image != null
                                              ? FileImage(File(image!.path))
                                              : NetworkImage(
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
                              Positioned(
                                top: 0,
                                right: 110.w,
                                child: InkWell(
                                  onTap: () {
                                    showImageBottomSheet(
                                      context,
                                      () async {
                                        Navigator.pop(context);
                                        image = await ImagePicker().pickImage(
                                          source: ImageSource.camera,
                                        );
                                        if (image != null) {
                                          BlocProvider.of<AccountBloc>(
                                            context,
                                          ).add(SetImage(image!));
                                        }
                                      },
                                      () async {
                                        Navigator.pop(context);
                                        image = await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (image != null) {
                                          BlocProvider.of<AccountBloc>(
                                            context,
                                          ).add(SetImage(image!));
                                        }
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightBackground,
                                      borderRadius: BorderRadius.circular(50.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Center(child: Icon(Icons.edit)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80.h),
                    CustomTextField(
                      controller: ownerNameController,
                      hintText: AppLocalization.of(
                        context,
                      ).translate("merchant_name"),
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: storeNameController,
                      hintText: AppLocalization.of(
                        context,
                      ).translate("shop_name"),
                      prefixIcon: Icons.store_outlined,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: addressController,
                      hintText: AppLocalization.of(
                        context,
                      ).translate("address"),
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: AppLocalization.of(
                        context,
                      ).translate("description"),
                      maxLines: 3,
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: AppLocalization.of(context).translate("edit"),
                          onPressed: () {
                            BlocProvider.of<AccountBloc>(context).add(
                              EditSellerProfileEvent(
                                SignUpMerchantModel(
                                  store_owner_name: ownerNameController.text,
                                  store_name: storeNameController.text,
                                  address: addressController.text,
                                  description: descriptionController.text,
                                  logo: image,
                                  logoPathFromServer:
                                      image == null ? state.seller?.logo : null,
                                  coverImage: coverImage,
                                  coverImagePathFromServer:
                                  coverImage == null ? state.seller?.coverImage : null,
                                  email: "",
                                  password: "",
                                  password_confirmation: "",
                                  phone: "",
                                ),
                                context,
                                formKey,
                              ),
                            );
                          },
                          isLoading:
                              state.editSellerProfileState == StateEnum.loading,
                        );
                      },
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
