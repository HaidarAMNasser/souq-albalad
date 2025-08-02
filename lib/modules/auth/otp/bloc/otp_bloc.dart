import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/forget_password/forgetPasswordApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/auth/otp/bloc/otp_events.dart';
import 'package:souq_al_balad/modules/auth/otp/bloc/otp_states.dart';
import 'package:souq_al_balad/modules/auth/reset_password/view/screen/reset_password_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OtpBloc extends Bloc<OtpEvents, OtpState> {
  OtpBloc() : super(OtpState()) {
    on<SendOtpEvent>(_sendOtpEvent);
    //on<OtpWithFacebook>(_OtpWithFacebook);
    //on<OtpWithGmail>(_OtpWithGmail);
  }

  void _sendOtpEvent(SendOtpEvent event, Emitter<OtpState> emit) async {
    emit(state.copyWith(otpState: StateEnum.loading));
    ResponseState<MessageModel> response = await ForgetPasswordApi().verifyOtp(
      event.email.trim(),
      event.otp,
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        //navigate to reset password
        String token = res.data.result['token'];
        emit(state.copyWith(otpState: StateEnum.start));
        Get.to(
          () => ResetPasswordScreen(email: event.email.trim(), token: token),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            otpState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(otpState: StateEnum.start));
    }
  }
}
