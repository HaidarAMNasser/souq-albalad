import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/forget_password/forgetPasswordApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/bloc/forget_password_events.dart';
import 'package:souq_al_balad/modules/auth/forgot_password/bloc/forget_password_states.dart';
import 'package:souq_al_balad/modules/auth/otp/view/screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordState()) {
    on<ForgetPasswordEvent>(_forgetPasswordEvent);
    //on<ForgetPasswordWithFacebook>(_ForgetPasswordWithFacebook);
    //on<ForgetPasswordWithGmail>(_ForgetPasswordWithGmail);
  }

  void _forgetPasswordEvent(
    ForgetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(state.copyWith(forgetPassState: StateEnum.loading));
    ResponseState<MessageModel> response = await ForgetPasswordApi().forget(
      event.email.trim(),
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        Get.to(() => OtpScreen(email: event.email));
        // إظهار رسالة نجاح

        ScaffoldMessenger.of(event.context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال رسالة استعادة كلمة المرور بنجاح'),
            backgroundColor: Color(0xFF2E8B8B),
          ),
        );

        emit(state.copyWith(forgetPassState: StateEnum.start));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            forgetPassState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(forgetPassState: StateEnum.start));
    }
  }
}
