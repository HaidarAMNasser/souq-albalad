import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/validators/email_validator.dart';
import 'package:souq_al_balad/global/utils/validators/required_validator.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/bloc/forget_password_bloc.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/bloc/forget_password_events.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/bloc/forget_password_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: formKey,
              child: Column(
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
                  const LogoAppWidget(),
                  SizedBox(height: 1.sh * 0.08),
                  TextBoldApp(
                    text: AppLocalization.of(
                      context,
                    ).translate("forget_password"),
                  ),
                  SizedBox(height: 1.sh * 0.05),
                  CustomTextField(
                    controller: emailController,
                    hintText: AppLocalization.of(context).translate("email"),
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (!RequiredValidator().validate(value ?? '')) {
                        return RequiredValidator().getMessage(context);
                      } else if (!EmailValidator().validate(value ?? '')) {
                        return EmailValidator().getMessage(context);
                      }
                      return null;
                    },
                    onChanged: (s) => {},
                    isRequired: true,
                  ),
                  SizedBox(height: 1.sh * 0.03),
                  NasAswadRafee(
                    text: AppLocalization.of(
                      context,
                    ).translate("send_message_to_reset_password"),
                    sizeFont: 16,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.sh * 0.05),
                  // زر الإرسال
                  BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: AppLocalization.of(context).translate("send"),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<ForgetPasswordBloc>(context).add(
                              ForgetPasswordEvent(
                                emailController.text,
                                context,
                              ),
                            );
                          }
                        },
                        isLoading: state.forgetPassState == StateEnum.loading,
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

  void _handleSendResetEmail() {
    print('إرسال رسالة استعادة كلمة المرور إلى: ${emailController.text}');
    // تنفيذ منطق إرسال رسالة استعادة كلمة المرور
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
