import 'package:souq_al_balad/global/components/app_loader.dart';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/image_pick.dart';
import 'package:souq_al_balad/global/components/show_dialog_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/app_urls.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc()..add(GetUserProfileEvent(context)),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            AppLocalization.of(context).translate("edit_account"),
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
            if (state.userProfileState == StateEnum.Success) {
              final user = state.user!;
              nameController.text = user.name ?? '';
              ageController.text = user.age ?? '';
              phoneController.text = user.phone ?? '';
            }

            if (state.userProfileState == StateEnum.loading) {
              return Center(child: AppLoader(size: 30.w));
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 1.sw,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (state.user!.logoPathFromServer != null ||
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
                                                              .user!
                                                              .logoPathFromServer!,
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                image: DecorationImage(
                                  image:
                                      image != null
                                          ? FileImage(File(image!.path))
                                          : NetworkImage(
                                            state.user!.logoPathFromServer ==
                                                    null
                                                ? ""
                                                : AppUrls.imageUrl +
                                                    state
                                                        .user!
                                                        .logoPathFromServer!,
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
                    SizedBox(height: 50.h),
                    CustomTextField(
                      controller: nameController,
                      hintText: AppLocalization.of(context).translate("name"),
                      prefixIcon: Icons.person_outline,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: phoneController,
                      hintText: AppLocalization.of(
                        context,
                      ).translate("phone_number"),
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: ageController,
                      hintText: AppLocalization.of(context).translate("age"),
                      prefixIcon: Icons.cake_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 40.h),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        return CustomButton(
                          text: AppLocalization.of(context).translate("edit"),
                          onPressed: () {
                            BlocProvider.of<AccountBloc>(context).add(
                              EditUserProfileEvent(
                                UserModel(
                                  name: nameController.text,
                                  age: ageController.text,
                                  phone: phoneController.text,
                                  email: state.user!.email,
                                  logo: image,
                                  logoPathFromServer:
                                      image == null
                                          ? state.user?.logoPathFromServer
                                          : null,
                                ),
                                context,
                                formKey,
                              ),
                            );
                          },
                          isLoading:
                              state.editUserProfileState == StateEnum.loading,
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
