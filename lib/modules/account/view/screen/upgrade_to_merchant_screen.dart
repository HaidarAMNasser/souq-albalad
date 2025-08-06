import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/image_pick.dart';
import 'package:souq_al_balad/global/components/show_dialog_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';

class UpgradeToMerchantScreen extends StatefulWidget {
  const UpgradeToMerchantScreen({super.key});

  @override
  State<UpgradeToMerchantScreen> createState() =>
      _UpgradeToMerchantScreenState();
}

class _UpgradeToMerchantScreenState extends State<UpgradeToMerchantScreen> {
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;
  XFile? coverImage;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => AccountBloc(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            AppLocalization.of(context).translate("upgrade_to_merchant_account"),
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
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                if (coverImage != null) {
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
                                              image: FileImage(
                                                File(coverImage!.path)),
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
                                height: 200.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: isDark ? AppColors.darkCardBackground : AppColors.lightCardBackground,
                                  image: DecorationImage(
                                    image: FileImage(File(
                                        coverImage == null ? "" :
                                        coverImage!.path)
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
                                  if (image != null) {
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
                                                image: FileImage(
                                                  File(image!.path)),
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
                                  width: 100.w,
                                  height: 100.w,
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
                                      image: FileImage(File(
                                          image == null ? "" :
                                          image!.path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 120.w,
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
                    SizedBox(height: 70.h),
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
                      hintText: AppLocalization.of(context).translate("shop_name"),
                      prefixIcon: Icons.store_outlined,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: phoneController,
                      hintText: AppLocalization.of(context).translate("phone_number"),
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: addressController,
                      hintText: AppLocalization.of(context).translate("address"),
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: AppLocalization.of(context).translate("description"),
                      maxLines: 3,
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: AppLocalization.of(
                            context,
                          ).translate("create_account"),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                                SignUpMerchantModel
                                signUpMerchantModel = SignUpMerchantModel(
                                  store_owner_name: ownerNameController.text,
                                  store_name: storeNameController.text,
                                  address: addressController.text,
                                  description: descriptionController.text,
                                  phone: phoneController.text,
                                  logo: image,
                                  coverImage: coverImage,
                                  email: '',
                                  password: '',
                                  password_confirmation: ''
                                );
                                BlocProvider.of<AccountBloc>(context).add(
                                  UpdateUserToSellerEvent(
                                    signUpMerchantModel,
                                    context,
                                    formKey,
                                  ),
                                );
                            }
                          },
                          isLoading: state.updateUserToSellerState == StateEnum.loading,
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
      ),
    );
  }
}
