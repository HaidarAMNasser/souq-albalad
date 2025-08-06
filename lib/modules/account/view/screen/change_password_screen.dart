import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/validators/match_password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/required_validator.dart';
import 'package:souq_al_balad/modules/account/bloc/account_bloc.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        child: const Icon(Icons.arrow_back_outlined),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.sh * 0.02),
                  Center(child: const LogoAppWidget()),
                  SizedBox(height: 1.sh * 0.08),
                  SizedBox(height: 20.h),
                  CustomTextField(
                    controller: oldPasswordController,
                    hintText: AppLocalization.of(
                      context,
                    ).translate("old_password"),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    onChanged: (s) => {},
                    isRequired: true,
                    validator: (value) {
                      if (!RequiredValidator().validate(value ?? '')) {
                        return RequiredValidator().getMessage(context);
                      } else if (!PasswordValidator().validate(value ?? '')) {
                        return PasswordValidator().getMessage(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: newPasswordController,
                    hintText: AppLocalization.of(
                      context,
                    ).translate("new_password"),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    isRequired: true,
                    onChanged: (s) => {},
                    validator: (value) {
                      if (!RequiredValidator().validate(value ?? '')) {
                        return RequiredValidator().getMessage(context);
                      } else if (!PasswordValidator().validate(value ?? '')) {
                        return PasswordValidator().getMessage(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: AppLocalization.of(
                      context,
                    ).translate("confirm_password"),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    isRequired: true,
                    onChanged: (s) => {},
                    validator: (value) {
                      if (!RequiredValidator().validate(value ?? '')) {
                        return RequiredValidator().getMessage(context);
                      } else if (!MatchPasswordValidator(
                        newPasswordController.text,
                      ).validate(value ?? '')) {
                        return MatchPasswordValidator(
                          newPasswordController.text,
                        ).getMessage(context);
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 50.h),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      if (state.changePassState == StateEnum.end) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          oldPasswordController.clear();
                          newPasswordController.clear();
                          confirmPasswordController.clear();
                        });
                      }
                      return CustomButton(
                        width: 1.sw,
                        backgroundColor: AppColors.primary,
                        borderRadius: 10.r,
                        text: AppLocalization.of(context).translate("edit"),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AccountBloc>(context).add(
                              ChangePasswordEvent(
                                oldPasswordController.text,
                                newPasswordController.text,
                                confirmPasswordController.text,
                                context,
                              ),
                            );
                          }
                        },
                        isLoading: state.changePassState == StateEnum.loading,
                      );
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
