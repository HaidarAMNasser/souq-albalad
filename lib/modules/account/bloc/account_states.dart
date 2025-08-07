import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/seller/models/seller_model.dart';
import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';
import 'package:image_picker/image_picker.dart';

class AccountState {
  StateEnum logoutState;
  StateEnum changePassState;
  StateEnum sellerProfileState;
  StateEnum editSellerProfileState;
  StateEnum userProfileState;
  StateEnum editUserProfileState;
  String errorMessage;
  SellerInfoModel? seller;
  UserModel? user;
  final XFile? image;

  AccountState({
    this.logoutState = StateEnum.start,
    this.changePassState = StateEnum.start,
    this.sellerProfileState = StateEnum.loading,
    this.editSellerProfileState = StateEnum.start,
    this.userProfileState = StateEnum.loading,
    this.editUserProfileState = StateEnum.start,
    this.errorMessage = '',
    this.seller,
    this.user,
    this.image,
  });

  AccountState copyWith({
    StateEnum? logoutState,
    StateEnum? changePassState,
    StateEnum? sellerProfileState,
    StateEnum? editSellerProfileState,
    StateEnum? userProfileState,
    StateEnum? editUserProfileState,
    String? errorMessage,
    SellerInfoModel? seller,
    UserModel? user,
    XFile? image,
    bool setImageToNull = false,
  }) {
    return AccountState(
      logoutState: logoutState ?? this.logoutState,
      changePassState: changePassState ?? this.changePassState,
      sellerProfileState: sellerProfileState ?? this.sellerProfileState,
      editSellerProfileState:
          editSellerProfileState ?? this.editSellerProfileState,
      userProfileState: userProfileState ?? this.userProfileState,
      editUserProfileState: editUserProfileState ?? this.editUserProfileState,
      errorMessage: errorMessage ?? this.errorMessage,
      seller: seller ?? this.seller,
      user: user ?? this.user,
      image: setImageToNull ? null : image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [AccountState, errorMessage, image];
}
