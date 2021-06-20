import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class ResetPasswordState {}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  final String message;

  ResetPasswordFailureState(this.message);
}

class ResetPasswordSuccessState extends ResetPasswordState {}

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final _service = AuthService();

  ResetPasswordCubit() : super(ResetPasswordInitialState());

  resetPassword(String email, String token, String password) async {
    emit(ResetPasswordLoadingState());
    final _response = await _service.resetPassword(email, token, password);
    if (_response is Exception) {
      emit(ResetPasswordFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(ResetPasswordFailureState(_response['message']))
          : emit(ResetPasswordSuccessState());
    }
  }
}
