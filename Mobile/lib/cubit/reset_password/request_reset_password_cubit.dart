import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class RequestResetPasswordState {}

class RequestResetPasswordInitialState extends RequestResetPasswordState {}

class RequestResetPasswordLoadingState extends RequestResetPasswordState {}

class RequestResetPasswordFailureState extends RequestResetPasswordState {
  final String message;

  RequestResetPasswordFailureState(this.message);
}

class RequestResetPasswordSuccessState extends RequestResetPasswordState {}

class RequestResetPasswordCubit extends Cubit<RequestResetPasswordState> {
  final AuthService _service = AuthService();

  RequestResetPasswordCubit() : super(RequestResetPasswordInitialState());

  requestResetPassword(String email) async {
    emit(RequestResetPasswordLoadingState());
    final _response = await _service.requestTokenResetPassword(email);
    if (_response is Exception) {
      emit(RequestResetPasswordFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(RequestResetPasswordFailureState(_response['message']))
          : emit(RequestResetPasswordSuccessState());
    }
  }
}
