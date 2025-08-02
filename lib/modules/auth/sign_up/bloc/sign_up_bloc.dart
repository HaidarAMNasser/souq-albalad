import 'dart:async';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/data/remote/firebase_api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/models/error_model.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/notification/notificationApi.dart';
import 'package:souq_al_balad/global/endpoints/signup/signupApi.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/auth/sign_up/bloc/sign_up_events.dart';
import 'package:souq_al_balad/modules/auth/sign_up/bloc/sign_up_states.dart';
import 'package:souq_al_balad/modules/home/view/screen/home_screen.dart';
import 'package:souq_al_balad/modules/navigation_bar/view/screen/main_layout_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<SignUpUserEvent>(_signUpEvent);
    on<SignUpMerchantEvent>(_signUpMerchantEvent);
    on<SetIsTrader>(_setIsTrader);
    on<SetImage>(_setImage);
    //on<SignUpWithFacebook>(_SignUpWithFacebook);
    //on<SignUpWithGmail>(_SignUpWithGmail);
  }

  void _signUpEvent(SignUpUserEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(signUpState: StateEnum.loading, errors: null));
    ResponseState<MessageModel> response = await SignupApi().signupUser(
      event.signUpModel,
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        //navigate to otp
        await saveData(res);

        String fcmToken = await FirebaseApi().getDeviceToken();
        await NotificationApi().sendFcmToken(fcmToken);

        emit(state.copyWith(signUpState: StateEnum.start));
        Get.to(() => const MainLayoutScreen());

        Fluttertoast.showToast(msg: res.data.message);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(res.data.result);
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            signUpState: StateEnum.start,
            errors: errorModel,
          ),
        );
        //لاظهار رسائل الخطأ من السيرفر
        event.formKey.currentState!.validate();
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      ErrorModel errorModel = ErrorModel.fromJson(
        res.errorMessage.error!.result,
      );
      emit(state.copyWith(signUpState: StateEnum.failed, errors: errorModel));
      event.formKey.currentState!.validate();

      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
    }
  }

  void _signUpMerchantEvent(
    SignUpMerchantEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(signUpState: StateEnum.loading));
    ResponseState<MessageModel> response = await SignupApi().signupMerchant(
      event.signUpModel,
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        //navigate to otp

        await saveData(res);

        String fcmToken = await FirebaseApi().getDeviceToken();
        await NotificationApi().sendFcmToken(fcmToken);

        emit(state.copyWith(signUpState: StateEnum.start));
        Get.to(() => const MainLayoutScreen());

        Fluttertoast.showToast(msg: res.data.message);
      } else {
        ErrorModel errorModel = ErrorModel.fromJson(res.data.result);
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            signUpState: StateEnum.start,
            errors: errorModel,
          ),
        );
        //لاظهار رسائل الخطأ من السيرفر
        event.formKey.currentState!.validate();
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(signUpState: StateEnum.start));
    }
  }

  /*
  FutureOr<void> _SignUpWithFacebook(
      SignUpWithFacebook event, Emitter<SignUpState> emit) async {}

  FutureOr<void> _SignUpWithGmail(
      SignUpWithGmail event, Emitter<SignUpState> emit) async {}
*/
  FutureOr<void> _setIsTrader(SetIsTrader event, Emitter<SignUpState> emit) {
    emit(state.copyWith(isTrader: event.isTrader));
    CacheHelper.saveData(
      key: accountType,
      value: event.isTrader ? 'seller' : 'customer',
    );
  }

  Future<bool> saveData(SuccessState<MessageModel> res) async {
    String token = res.data.result['token'];
    CacheHelper.saveData(key: 'token', value: token);
    return true;
  }

  FutureOr<void> _setImage(SetImage event, Emitter<SignUpState> emit) {
    emit(
      state.copyWith(setImageToNull: event.image == null, image: event.image),
    );
  }
}
