import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class VerifyResetPasswordTokenState {}

class VerifyResetPasswordTokenInitialState
    extends VerifyResetPasswordTokenState {}

class VerifyResetPasswordTokenLoadingState
    extends VerifyResetPasswordTokenState {}

class VerifyResetPasswordTokenFailureState
    extends VerifyResetPasswordTokenState {
  final String message;

  VerifyResetPasswordTokenFailureState(this.message);
}

class VerifyResetPasswordTokenSuccessState
    extends VerifyResetPasswordTokenState {}

class VerifyResetPasswordTokenCubit
    extends Cubit<VerifyResetPasswordTokenState> {
  final AuthService _service = AuthService();

  VerifyResetPasswordTokenCubit()
      : super(VerifyResetPasswordTokenInitialState());

  verify(String email, String token) async {
    emit(VerifyResetPasswordTokenLoadingState());
    final _response = await _service.verifyTokenResetPassword(email, token);
    if (_response is Exception) {
      emit(VerifyResetPasswordTokenFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(VerifyResetPasswordTokenFailureState(_response['message']))
          : emit(VerifyResetPasswordTokenSuccessState());
    }
  }
}
