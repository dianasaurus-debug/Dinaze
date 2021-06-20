import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class LogoutState {}

class LogoutInitialState extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutFailureState extends LogoutState {
  final String message;

  LogoutFailureState(this.message);
}

class LogoutSuccessState extends LogoutState {}

class LogoutCubit extends Cubit<LogoutState> {
  final AuthService _service = AuthService();

  LogoutCubit() : super(LogoutInitialState());

  void resetState() => emit(LogoutInitialState());

  void logout() async {
    final _response = await _service.logout();
    if (_response is Exception) {
      emit(LogoutFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(LogoutFailureState(_response['message']))
          : emit(LogoutSuccessState());
    }
  }
}
