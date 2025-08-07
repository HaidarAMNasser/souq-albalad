import 'dart:async';
import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/endpoints/change_password/changePasswordApi.dart';
import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart'
    show StateEnum;
import 'package:souq_al_balad/global/endpoints/logout/logoutApi.dart';
import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:souq_al_balad/global/endpoints/seller/models/seller_model.dart';
import 'package:souq_al_balad/global/endpoints/seller/sellerApi.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:souq_al_balad/global/endpoints/user/userApi.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/account/bloc/account_event.dart';
import 'package:souq_al_balad/modules/account/bloc/account_states.dart';
import 'package:souq_al_balad/modules/auth/log_in/view/screen/log_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AccountBloc extends Bloc<AccountEvents, AccountState> {
  AccountBloc() : super(AccountState()) {
    on<LogoutEvent>(_logoutEvent);
    on<ChangePasswordEvent>(_changePasswordEvent);
    on<GetSellerProfileEvent>(_getSellerProfileEvent);
    on<SetImage>(_setImage);
    on<EditSellerProfileEvent>(_editSellerProfileEvent);
    on<GetUserProfileEvent>(_getUserProfileEvent);
    on<EditUserProfileEvent>(_editUserProfileEvent);
  }

  void _logoutEvent(AccountEvents event, Emitter<AccountState> emit) async {
    emit(state.copyWith(logoutState: StateEnum.loading));
    ResponseState<MessageModel> response = await LogoutApi().logout();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        await CacheHelper.removeData(key: 'token').then((value) {
          CacheHelper.removeData(key: accountType);
          Get.offAll(() => const LoginScreen());
        });
        emit(state.copyWith(logoutState: StateEnum.Success));
      } else {
        emit(state.copyWith(errorMessage: res.data.message));
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(logoutState: StateEnum.start));
    }
  }

  void _changePasswordEvent(
    ChangePasswordEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(changePassState: StateEnum.loading));
    ResponseState<MessageModel> response = await ChangePasswordApi()
        .changePassword(
          event.oldPassword,
          event.password,
          event.confirmPassword,
        );
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        Fluttertoast.showToast(msg: res.data.message);
        emit(state.copyWith(changePassState: StateEnum.end));
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            changePassState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(changePassState: StateEnum.start));
    }
  }

  void _getSellerProfileEvent(
    GetSellerProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(sellerProfileState: StateEnum.loading));
    ResponseState<MessageModel> response = await SellerApi().getSellerProfile();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        SellerInfoModel sellerInfoModel = SellerInfoModel.fromJson(
          res.data.result["seller"],
        );
        emit(
          state.copyWith(
            sellerProfileState: StateEnum.Success,
            seller: sellerInfoModel,
          ),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            sellerProfileState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(sellerProfileState: StateEnum.start));
    }
  }

  FutureOr<void> _setImage(SetImage event, Emitter<AccountState> emit) {
    emit(
      state.copyWith(setImageToNull: event.image == null, image: event.image),
    );
  }

  void _editSellerProfileEvent(
    EditSellerProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(editSellerProfileState: StateEnum.loading));
    final response = await SellerApi().editSellerProfile(event.seller);
    if (response is SuccessState) {
      final res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        final sellerInfoModel = SellerInfoModel.fromJson(
          res.data.result["seller"],
        );
        emit(
          state.copyWith(
            seller: sellerInfoModel,
            editSellerProfileState: StateEnum.end,
          ),
        );
        await Future.delayed(const Duration(milliseconds: 100));
        emit(state.copyWith(editSellerProfileState: StateEnum.start));
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            editSellerProfileState: StateEnum.start,
          ),
        );
      }
    } else if (response is ErrorState) {
      final res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error?.message ?? 'Error');
      emit(state.copyWith(editSellerProfileState: StateEnum.start));
    }
  }

  void _getUserProfileEvent(
    GetUserProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(userProfileState: StateEnum.loading));
    ResponseState<MessageModel> response = await UserApi().getUserProfile();
    if (response is SuccessState) {
      SuccessState<MessageModel> res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        UserModel userModel = UserModel.fromJson(res.data.result["user"]);
        emit(
          state.copyWith(userProfileState: StateEnum.Success, user: userModel),
        );
      } else {
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            userProfileState: StateEnum.start,
          ),
        );
        Fluttertoast.showToast(msg: res.data.message);
      }
    } else if (response is ErrorState) {
      ErrorState<MessageModel> res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error!.message);
      emit(state.copyWith(userProfileState: StateEnum.start));
    }
  }

  void _editUserProfileEvent(
    EditUserProfileEvent event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(editUserProfileState: StateEnum.loading));
    final response = await UserApi().editUserProfile(event.user);
    if (response is SuccessState) {
      final res = response as SuccessState<MessageModel>;
      if (res.data.success) {
        final userModel = UserModel.fromJson(res.data.result["user"]);
        emit(
          state.copyWith(user: userModel, editUserProfileState: StateEnum.end),
        );
        await Future.delayed(const Duration(milliseconds: 100));
        emit(state.copyWith(editUserProfileState: StateEnum.start));
      } else {
        Fluttertoast.showToast(msg: res.data.message);
        emit(
          state.copyWith(
            errorMessage: res.data.message,
            editUserProfileState: StateEnum.start,
          ),
        );
      }
    } else if (response is ErrorState) {
      final res = response as ErrorState<MessageModel>;
      Fluttertoast.showToast(msg: res.errorMessage.error?.message ?? 'Error');
      emit(state.copyWith(editUserProfileState: StateEnum.start));
    }
  }
}
