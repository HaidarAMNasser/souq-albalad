import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/global/utils/validators/required_validator.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/view/screen/forgot_password_screen.dart';
import 'package:souq_al_balad/modules/auth/log_in/bloc/logIn_bloc.dart';
import 'package:souq_al_balad/modules/auth/log_in/bloc/logIn_events.dart';
import 'package:souq_al_balad/modules/auth/log_in/bloc/logIn_states.dart';
import 'package:souq_al_balad/modules/auth/sign_up/view/screen/create_account.dart';
import 'package:souq_al_balad/modules/navigation_bar/view/screen/main_layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 1.sh * 0.05),
                  const LogoAppWidget(),
                  SizedBox(height: 1.sh * 0.05),
                  TextBoldApp(
                    text: AppLocalization.of(context).translate("welcome"),
                  ),
                  const SizedBox(height: 16),
                  NasAswadRafee(
                    text: AppLocalization.of(
                      context,
                    ).translate("login_to_get_started"),
                    sizeFont: 18,
                  ),
                  SizedBox(height: 1.sh * 0.03),
                  _buildInputFields(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FontWastFadi(
                          text: AppLocalization.of(
                            context,
                          ).translate("forget_password"),
                          color: AppColors.primary2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.sh * 0.04),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: AppLocalization.of(context).translate("login"),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(
                              LoginEvent(
                                emailController.text,
                                passwordController.text,
                                context,
                              ),
                            );
                          }
                        },
                        isLoading: state.loginState == StateEnum.loading,
                      );
                    },
                  ),
                  SizedBox(height: 1.sh * 0.02),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: AppLocalization.of(
                          context,
                        ).translate("login_as_guest"),
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(
                            context,
                          ).add(LoginGuestEvent(context));
                        },
                        isLoading: state.loginGuestState == StateEnum.loading,
                      );
                    },
                  ),
                  SizedBox(height: 1.sh * 0.03),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: NasAswadRafee(
                      text: AppLocalization.of(
                        context,
                      ).translate("or_login_with"),
                      sizeFont: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 1.sh * 0.03),
                  _buildSocialLoginButtons(),
                  SizedBox(height: 1.sh * 0.02),
                  _buildCreateAccountLink(),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: AppLocalization.of(context).translate("email"),
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (!RequiredValidator().validate(value ?? '')) {
              return RequiredValidator().getMessage(context);
            }
            return null;
          },
          onChanged: (s) => {},
          isRequired: true,
        ),
        SizedBox(height: 20.h),
        CustomTextField(
          controller: passwordController,
          hintText: AppLocalization.of(context).translate("password"),
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) {
            if (!RequiredValidator().validate(value ?? '')) {
              return RequiredValidator().getMessage(context);
            }
            return null;
          },
          onChanged: (s) => {},
          isRequired: true,
        ),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(
          onTap: () => _handleSocialLogin('Google'),
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r)),
            child: SvgPicture.asset(ImagesApp.google),
          ),
        ),
        _buildSocialButton(
          onTap: () => _handleSocialLogin('Apple'),
          child: Icon(
            Icons.apple,
            size: 30,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        _buildSocialButton(
          onTap: () => _handleSocialLogin('Facebook'),
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              color: Color(0xFF1877F2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.facebook, size: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: const Color(0xFFFF8C42), // البرتقالي للحدود
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _buildCreateAccountLink() {
    return TextButton(
      onPressed: () {
        Get.to(() => const RegisterScreen());
      },
      child: Text(
        AppLocalization.of(context).translate("create_account"),
        style: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFFFF8C42),
        ),
      ),
    );
  }

  void _handleLogin() {
    print('تسجيل دخول: ${emailController.text}');
    // تنفيذ منطق تسجيل الدخول
  }

  void _handleGuestLogin() {
    print('تسجيل دخول كزائر');
  }

  void _handleSocialLogin(String provider) {
    print('تسجيل دخول عبر: $provider');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
