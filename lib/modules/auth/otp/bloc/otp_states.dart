import 'package:souq_al_balad/global/endpoints/core/enum/state_enum.dart';

class OtpState {
  StateEnum otpState;
  String errorMessage;
  OtpState({this.otpState = StateEnum.start, this.errorMessage = ''});

  OtpState copyWith({StateEnum? otpState, String? errorMessage}) {
    return OtpState(
      otpState: otpState ?? this.otpState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
