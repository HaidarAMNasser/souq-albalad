import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/forget_password/models/reset_password_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/validators/match_password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/required_validator.dart';
import 'package:souq_al_balad/modules/auth/reset_password/bloc/reset_password_bloc.dart';
import 'package:souq_al_balad/modules/auth/reset_password/bloc/reset_password_events.dart';
import 'package:souq_al_balad/modules/auth/reset_password/bloc/reset_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String token;

  const ResetPasswordScreen({
    required this.email,
    required this.token,
    super.key,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(),
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
                    controller: passwordController,
                    hintText: AppLocalization.of(context).translate("password"),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
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
                  // إعادة كلمة المرور
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: AppLocalization.of(
                      context,
                    ).translate("reset_password"),
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator: (value) {
                      if (!RequiredValidator().validate(value ?? '')) {
                        return RequiredValidator().getMessage(context);
                      } else if (!MatchPasswordValidator(
                        passwordController.text,
                      ).validate(value ?? '')) {
                        return MatchPasswordValidator(
                          passwordController.text,
                        ).getMessage(context);
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 50.h),
                  BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        width: 1.sw,
                        backgroundColor: AppColors.primary,
                        borderRadius: 10.r,
                        text: AppLocalization.of(
                          context,
                        ).translate("reset_password"),
                        // todo remove later
                        onPressed: () {
                          BlocProvider.of<ResetPasswordBloc>(context).add(
                            ResetPasswordEvent(
                              ResetPasswordModel(
                                email: widget.email,
                                token: widget.token,
                                password: passwordController.text,
                                password_confirmation:
                                    confirmPasswordController.text,
                              ),
                              context,
                            ),
                          );
                        },
                        isLoading:
                            state.resetPasswordState == StateEnum.loading,
                      );
                    },
                  ),

                  SizedBox(height: 30.h),
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  int numberOfFields() => 2;
}
