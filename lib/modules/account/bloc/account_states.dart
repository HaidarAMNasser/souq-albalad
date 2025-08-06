import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/product/models/product_bundle.dart';
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
  StateEnum updateUserToSellerState;
  StateEnum sellerProductsState;
  StateEnum deleteSellerProductState;
  String errorMessage;
  SellerInfoModel? seller;
  UserModel? user;
  final XFile? image;
  List<ProductBundleModel>? sellerProducts;
  int? productId;

  AccountState({
    this.logoutState = StateEnum.start,
    this.changePassState = StateEnum.start,
    this.sellerProfileState = StateEnum.loading,
    this.editSellerProfileState = StateEnum.start,
    this.userProfileState = StateEnum.loading,
    this.editUserProfileState = StateEnum.start,
    this.updateUserToSellerState = StateEnum.start,
    this.sellerProductsState = StateEnum.loading,
    this.deleteSellerProductState = StateEnum.start,
    this.errorMessage = '',
    this.seller,
    this.user,
    this.image,
    this.sellerProducts,
    this.productId
  });

  AccountState copyWith({
    StateEnum? logoutState,
    StateEnum? changePassState,
    StateEnum? sellerProfileState,
    StateEnum? editSellerProfileState,
    StateEnum? userProfileState,
    StateEnum? editUserProfileState,
    StateEnum? updateUserToSellerState,
    StateEnum? sellerProductsState,
    StateEnum? deleteSellerProductState,
    String? errorMessage,
    SellerInfoModel? seller,
    UserModel? user,
    XFile? image,
    bool setImageToNull = false,
    List<ProductBundleModel>? sellerProducts,
    int? productId

  }) {
    return AccountState(
      logoutState: logoutState ?? this.logoutState,
      changePassState: changePassState ?? this.changePassState,
      sellerProfileState: sellerProfileState ?? this.sellerProfileState,
      editSellerProfileState:
          editSellerProfileState ?? this.editSellerProfileState,
      userProfileState: userProfileState ?? this.userProfileState,
      editUserProfileState: editUserProfileState ?? this.editUserProfileState,
      updateUserToSellerState: updateUserToSellerState ?? this.updateUserToSellerState,
      sellerProductsState: sellerProductsState ?? this.sellerProductsState,
      deleteSellerProductState: deleteSellerProductState ?? this.deleteSellerProductState,
      errorMessage: errorMessage ?? this.errorMessage,
      seller: seller ?? this.seller,
      user: user ?? this.user,
      image: setImageToNull ? null : image ?? this.image,
      sellerProducts: sellerProducts ?? this.sellerProducts,
      productId: productId ?? this.productId
    );
  }

  @override
  List<Object?> get props => [AccountState, errorMessage, image];
}
