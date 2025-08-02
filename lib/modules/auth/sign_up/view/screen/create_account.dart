import 'dart:io';

import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/image_pick.dart';
import 'package:souq_al_balad/global/components/image_show.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/components/text_bold_app.dart';
import 'package:souq_al_balad/global/components/text_field_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/error_model.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_merchant_model.dart';
import 'package:souq_al_balad/global/endpoints/signup/models/sign_up_user_model.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/global/utils/images_file.dart';
import 'package:souq_al_balad/global/utils/validators/email_validator.dart';
import 'package:souq_al_balad/global/utils/validators/match_password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/password_validator.dart';
import 'package:souq_al_balad/global/utils/validators/required_validator.dart';
import 'package:souq_al_balad/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:souq_al_balad/modules/auth/sign_up/bloc/sign_up_events.dart';
import 'package:souq_al_balad/modules/auth/sign_up/bloc/sign_up_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // نوع الحساب المختار
  //bool state.isTrader = false; // false = مستخدم عادي، true = تاجر

  // Controllers للمستخدم العادي
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Controllers للتاجر
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController logoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController traderPasswordController =
      TextEditingController();
  final TextEditingController traderConfirmPasswordController =
      TextEditingController();
  bool signUpClicked = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 1.sh * 0.03),
                      const LogoAppWidget(),
                      SizedBox(height: 1.sh * 0.03),
                      TextBoldApp(
                        text: AppLocalization.of(
                          context,
                        ).translate("create_account"),
                        sizeFont: 24,
                      ),
                      SizedBox(height: 1.sh * 0.03),
                      _buildAccountTypeSelector(),
                      SizedBox(height: 1.sh * 0.03),
                      state.isTrader
                          ? _buildTraderFields()
                          : _buildUserFields(),
                      SizedBox(height: 1.sh * 0.02),
                      _buildTermsText(),
                      SizedBox(height: 1.sh * 0.03),
                      BlocBuilder<SignUpBloc, SignUpState>(
                        builder: (context, state) {
                          return CustomButton(
                            text: AppLocalization.of(
                              context,
                            ).translate("create_account"),
                            onPressed: () {
                              setState(() {
                                signUpClicked = true;
                              });
                              if (formKey.currentState!.validate()) {
                                if (state.isTrader) {
                                  SignUpMerchantModel
                                  signUpMerchantModel = SignUpMerchantModel(
                                    store_owner_name: ownerNameController.text,
                                    store_name: storeNameController.text,
                                    address: addressController.text,
                                    description: descriptionController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: traderPasswordController.text,
                                    password_confirmation:
                                        traderConfirmPasswordController.text,
                                    logo: state.image,
                                  );
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpMerchantEvent(
                                      signUpMerchantModel,
                                      context,
                                      formKey,
                                    ),
                                  );
                                } else {
                                  SignUpUserModel signUpUserModel =
                                      SignUpUserModel(
                                        name: nameController.text,
                                        age: ageController.text,
                                        password: passwordController.text,
                                        password_confirmation:
                                            confirmPasswordController.text,
                                        email:
                                            EmailValidator().validate(
                                                  emailOrPhoneController.text,
                                                )
                                                ? emailOrPhoneController.text
                                                : '',
                                        phone:
                                            EmailValidator().validate(
                                                  emailOrPhoneController.text,
                                                )
                                                ? ''
                                                : emailOrPhoneController.text,
                                      );
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpUserEvent(
                                      signUpUserModel,
                                      context,
                                      formKey,
                                    ),
                                  );
                                }
                                _handleRegister();
                                setState(() {
                                  signUpClicked = false;
                                });
                              }
                            },
                            isLoading: state.signUpState == StateEnum.loading,
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
                      SizedBox(height: 1.sh * 0.03),
                      _buildLoginLink(),
                      SizedBox(height: 50.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTypeSelector() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Row(
          children: [
            // زر المستخدم العادي
            Expanded(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<SignUpBloc>(context).add(SetIsTrader(false));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: !state.isTrader ? Colors.white : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color:
                          !state.isTrader
                              ? const Color(0xFF2E8B8B)
                              : Colors.grey[300]!,
                      width: !state.isTrader ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    AppLocalization.of(context).translate("user"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          !state.isTrader
                              ? const Color(0xFF2E8B8B)
                              : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // زر التاجر
            Expanded(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<SignUpBloc>(context).add(SetIsTrader(true));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: state.isTrader ? Colors.white : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color:
                          state.isTrader
                              ? const Color(0xFF2E8B8B)
                              : Colors.grey[300]!,
                      width: state.isTrader ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    AppLocalization.of(context).translate("merchant"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          state.isTrader
                              ? const Color(0xFF2E8B8B)
                              : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserFields() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            // الاسم
            CustomTextField(
              controller: nameController,
              hintText: AppLocalization.of(context).translate("name"),
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (!state.isTrader) {
                  return _validate(state.errors, 'name');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // العمر
            CustomTextField(
              controller: ageController,
              hintText: AppLocalization.of(context).translate("age"),
              prefixIcon: Icons.cake_outlined,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (!state.isTrader) {
                  return _validate(state.errors, 'age');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // البريد الإلكتروني أو رقم الهاتف
            CustomTextField(
              controller: emailOrPhoneController,
              hintText: AppLocalization.of(context).translate("phone_email"),
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (!state.isTrader) {
                  return _validate(state.errors, 'contact');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // كلمة المرور
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
                } else if (!state.isTrader) {
                  return _validate(state.errors, 'password');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // إعادة كلمة المرور
            CustomTextField(
              controller: confirmPasswordController,
              hintText: AppLocalization.of(context).translate("reset_password"),
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
                } else if (!state.isTrader) {
                  return _validate(state.errors, 'password');
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTraderFields() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Column(
          children: [
            // اسم صاحب المتجر
            CustomTextField(
              controller: ownerNameController,
              hintText: AppLocalization.of(context).translate("merchant_name"),
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'store_owner_name');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // اسم المتجر
            CustomTextField(
              controller: storeNameController,
              hintText: AppLocalization.of(context).translate("shop_name"),
              prefixIcon: Icons.store_outlined,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'store_name');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // العنوان
            CustomTextField(
              controller: addressController,
              hintText: AppLocalization.of(context).translate("address"),
              prefixIcon: Icons.location_on_outlined,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'address');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // الشعار
            CustomTextField(
              controller: logoController,
              hintText:
                  state.image == null
                      ? AppLocalization.of(context).translate("logo")
                      : state.image!.name,
              prefixIcon: Icons.image_outlined,
              suffix:
                  state.image != null
                      ? InkWell(
                        onTap: () {
                          BlocProvider.of<SignUpBloc>(
                            context,
                          ).add(SetImage(null));
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.grey700,
                        ),
                      )
                      : null,
              readOnly: true,
              onTap: () {
                if (state.image != null) {
                  Get.to(
                    Imageshow(
                      imageList: [File(state.image!.path)],
                      selectedIndex: 0,
                    ),
                  );
                } else {
                  XFile? image;
                  showImageBottomSheet(
                    context,
                    () async {
                      Navigator.pop(context);
                      image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                      );
                      if (image != null) {
                        BlocProvider.of<SignUpBloc>(
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
                        BlocProvider.of<SignUpBloc>(
                          context,
                        ).add(SetImage(image!));
                      }
                    },
                  );
                }
              },
            ),
            SizedBox(height: 16.h),
            // الوصف
            CustomTextField(
              controller: descriptionController,
              hintText: AppLocalization.of(context).translate("description"),
              maxLines: 3,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'description');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // رقم الهاتف
            CustomTextField(
              controller: phoneController,
              hintText: AppLocalization.of(context).translate("phone_number"),
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'phone');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // البريد الإلكتروني
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
                } else if (state.isTrader) {
                  return _validate(state.errors, 'email');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // كلمة المرور
            CustomTextField(
              controller: traderPasswordController,
              hintText: AppLocalization.of(context).translate("password"),
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (!PasswordValidator().validate(value ?? '')) {
                  return PasswordValidator().getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'password');
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            // إعادة كلمة المرور
            CustomTextField(
              controller: traderConfirmPasswordController,
              hintText: AppLocalization.of(context).translate("reset_password"),
              prefixIcon: Icons.lock_outline,
              isPassword: true,
              validator: (value) {
                if (!RequiredValidator().validate(value ?? '')) {
                  return RequiredValidator().getMessage(context);
                } else if (!MatchPasswordValidator(
                  traderPasswordController.text,
                ).validate(value ?? '')) {
                  return MatchPasswordValidator(
                    traderPasswordController.text,
                  ).getMessage(context);
                } else if (state.isTrader) {
                  return _validate(state.errors, 'password');
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            color: Colors.grey[600],
          ),
          children: [
            TextSpan(
              text: AppLocalization.of(context).translate("by_clicking"),
            ),
            const TextSpan(text: " "),
            TextSpan(
              text: AppLocalization.of(context).translate("register"),
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Color(0xFFFF8C42),
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: " "),
            TextSpan(text: AppLocalization.of(context).translate("button")),
            const TextSpan(text: ", "),
            TextSpan(
              text: AppLocalization.of(
                context,
              ).translate("you_agree_public_offer"),
            ),
          ],
        ),
      ),
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
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFFFF8C42), width: 2),
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

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalization.of(context).translate("have_an_account"),
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const Text(" "),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Text(
            AppLocalization.of(context).translate("login"),
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8C42),
            ),
          ),
        ),
      ],
    );
  }

  void _pickLogo() {
    // تنفيذ منطق اختيار الصورة
    print('اختيار شعار المتجر');
  }

  void _handleRegister() {
    /* if (traderConfirmPasswordController) {
      print('تسجيل تاجر جديد');
      print('اسم المالك: ${ownerNameController.text}');
      print('اسم المتجر: ${storeNameController.text}');
    } else {
      print('تسجيل مستخدم عادي جديد');
      print('الاسم: ${nameController.text}');
      print('العمر: ${ageController.text}');
    }
*/
    // تنفيذ منطق التسجيل
    // API call, validation, navigation
  }

  void _handleSocialLogin(String provider) {
    print('تسجيل عبر: $provider');
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailOrPhoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    ownerNameController.dispose();
    storeNameController.dispose();
    addressController.dispose();
    logoController.dispose();
    descriptionController.dispose();
    phoneController.dispose();
    emailController.dispose();
    traderPasswordController.dispose();
    traderConfirmPasswordController.dispose();
    super.dispose();
  }

  String? _validate(ErrorModel? errors, String field) {
    if (!signUpClicked && errors != null) return errors.getError(field);
    return null;
  }
}
