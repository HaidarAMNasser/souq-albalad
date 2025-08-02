import 'dart:async';
import 'package:souq_al_balad/global/components/button_app.dart';
import 'package:souq_al_balad/global/components/logo_app.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/utils/color_app.dart';
import 'package:souq_al_balad/modules/auth/otp/bloc/otp_bloc.dart';
import 'package:souq_al_balad/modules/auth/otp/bloc/otp_events.dart';
import 'package:souq_al_balad/modules/auth/otp/bloc/otp_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String? email;

  const OtpScreen({required this.email, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static PinTheme defaultPinTheme = PinTheme(
    width: 50.w,
    height: 80.h,
    textStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8.r),
    ),
  );
  static PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
    color: Colors.white,
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(8.r),
  );
  static PinTheme submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(color: Colors.white),
  );

  late TextEditingController codeController;
  Timer? timer;
  int _seconds = 60;
  bool enableResend = false;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();

    // todo enable later
    // FirebaseApi.verificationCodeNotifier.addListener(() {
    //   final code = FirebaseApi.verificationCodeNotifier.value;
    //   if (code != null && code.isNotEmpty) {
    //     setState(() {
    //       codeController.text = code;
    //     });
    //   }
    // });
    /*
    if (!widget.fromSingUp) {
      _seconds = 0;
    }
    */
    _startTimer();
  }

  void _resendCode() {
    setState(() {
      _seconds = 60;
      enableResend = false;
    });
    _startTimer();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds != 0) {
        setState(() {
          _seconds = _seconds - 1;
        });
      } else {
        setState(() {
          enableResend = true;
          timer.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                RichText(
                  text: TextSpan(
                    text:
                        "${AppLocalization.of(context).translate("we_sent_you_code")} ",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                    children: [
                      TextSpan(text: " "),
                      TextSpan(
                        text: "${widget.email} ",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),
                Pinput(
                  length: 6,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: codeController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                ),
                SizedBox(height: 50.h),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return CustomButton(
                      width: 1.sw,
                      backgroundColor: AppColors.primary,
                      borderRadius: 10.r,
                      text: AppLocalization.of(context).translate("verify"),
                      // todo remove later
                      onPressed: () {
                        BlocProvider.of<OtpBloc>(context).add(
                          SendOtpEvent(
                            widget.email!,
                            codeController.text,
                            context,
                          ),
                        );
                      },
                      isLoading: state.otpState == StateEnum.loading,
                    );
                  },
                ),
                SizedBox(height: 100.h),
                /*
                    CreateModel(
                      withValidation: false,
                      onSuccess: (result) {
                        _resendCode();
                      },
                      useCaseCallBack: (data) {
                        if (enableResend) {
                          codeController.clear();
                          return ResendCodeUseCase(AuthRepository()).call(
                              params: ResendCodeParams(phone: widget.phoneNumber));
                        } else {
                          return null;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              AppLocalization.of(context)
                                  .translate("did_not_receive_code"),
                              style: AppTheme.titleMedium.copyWith(fontSize: 14)),
                          SizedBox(width: 4.w),
                          Text(
                              !enableResend
                                  ? _seconds > 0
                                      ? ' ($_seconds)'
                                      : ''
                                  : AppLocalization.of(context).translate("resend"),
                              style: AppTheme.titleMedium.copyWith(
                                  fontSize: 14,
                                  color: AppColors.primaryColor,
                                  decoration: _seconds > 0
                                      ? null
                                      : TextDecoration.underline,
                                  decorationColor:
                                      _seconds > 0 ? null : AppColors.primaryColor))
                        ],
                      ),
                    ),
                    */
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
