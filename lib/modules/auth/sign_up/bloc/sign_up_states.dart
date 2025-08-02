import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';
import 'package:souq_al_balad/global/endpoints/models/error_model.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class SignUpState extends Equatable {
  final StateEnum signUpState;
  final String errorMessage;
  final ErrorModel? errors;
  final bool isTrader;
  final XFile? image;
  const SignUpState({
    this.signUpState = StateEnum.start,
    this.errorMessage = '',
    this.errors,
    this.isTrader = false,
    this.image,
  });

  SignUpState copyWith({
    StateEnum? signUpState,
    String? errorMessage,
    ErrorModel? errors,
    bool? isTrader,
    XFile? image,
    bool setImageToNull = false,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
      isTrader: isTrader ?? this.isTrader,
      image: setImageToNull ? null : image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
    signUpState,
    errorMessage,
    errors,
    isTrader,
    image,
  ];
}
