import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/forget_password/forgetPasswordApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:souq_al_balad/modules/auth/reset_password/bloc/reset_password_events.dart';
import 'package:souq_al_balad/modules/auth/reset_password/bloc/reset_password_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordState()) {
    on<ResetPasswordEvent>(_resetPasswordEvent);
    //on<ResetPasswordWithFacebook>(_ResetPasswordWithFacebook);
    //on<ResetPasswordWithGmail>(_ResetPasswordWithGmail);
  }

  void _resetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(resetPasswordState: StateEnum.loading));
    ResponseState<MessageModel> response = await ForgetPasswordApi()
        .resetPassword(event.resetPasswordModel);
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        //navigate to sign in

        emit(state.copyWith(resetPasswordState: StateEnum.start));
        Get.off(() => const LoginScreen());
        Fluttertoast.showToast(msg: res.data.message);
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            resetPasswordState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(resetPasswordState: StateEnum.start));
    }
  }
}
