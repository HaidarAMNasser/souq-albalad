import 'dart:async';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/data/remote/firebase_api.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/login/loginApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/notification/notificationApi.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/auth/log_in/bloc/logIn_events.dart';
import 'package:souq_al_balad/modules/auth/log_in/bloc/logIn_states.dart';
import 'package:souq_al_balad/modules/navigation_bar/view/screen/main_layout_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>(_loginEvent);
    on<LoginGuestEvent>(_loginGuestEvent);
    //on<LoginWithFacebook>(_LoginWithFacebook);
    //on<LoginWithGmail>(_LoginWithGmail);
  }

  void _loginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginState: StateEnum.loading));
    ResponseState<MessageModel> response = await LoginApi().login(
      event.email.trim(),
      event.password,
    );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        await saveData(res);
        String fcmToken = await FirebaseApi().getDeviceToken();
        await NotificationApi().sendFcmToken(fcmToken);
        CacheHelper.saveData(key: accountType, value: res.data.result["role"]);
        Fluttertoast.showToast(msg: res.data.message);
        Get.offAll(() => const MainLayoutScreen());
        emit(state.copyWith(loginState: StateEnum.start));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            loginState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(loginState: StateEnum.start));
    }
  }

  FutureOr<void> _loginGuestEvent(
    LoginGuestEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginGuestState: StateEnum.loading));
    ResponseState<MessageModel> response = await LoginApi().logInAsGuest();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        await saveData(res);

        String fcmToken = await FirebaseApi().getDeviceToken();
        await NotificationApi().sendFcmToken(fcmToken);

        Fluttertoast.showToast(msg: res.data.message);
        Get.offAll(() => const MainLayoutScreen());

        emit(state.copyWith(loginGuestState: StateEnum.start));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            loginGuestState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(loginGuestState: StateEnum.start));
    }
  }

  FutureOr<void> _LoginWithFacebook(
    LoginWithFacebook event,
    Emitter<LoginState> emit,
  ) async {}

  FutureOr<void> _LoginWithGmail(
    LoginWithGmail event,
    Emitter<LoginState> emit,
  ) async {}

  Future<bool> saveData(SuccessState<MessageModel> res) async {
    final Map<String, dynamic> resultData = res.data.result;

    final String token = resultData['token'];
    await CacheHelper.saveData(key: 'token', value: token);

    if (resultData.containsKey('user') &&
        resultData['user'] is Map &&
        resultData['user'].containsKey('id')) {
      final int userId = resultData['user']['id'];

      await CacheHelper.saveData(key: 'userId', value: userId);

      print("SUCCESS: Saved userId: $userId to cache.");
    } else {
      print(
          "CRITICAL ERROR: User ID could not be found in the login response.");
    }

    return true;
  }
}
