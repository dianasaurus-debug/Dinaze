import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  final String errorMessage;

  RegisterFailureState(this.errorMessage);
}

class RegisterSuccessState extends RegisterState {}

class RegisterCubit extends Cubit<RegisterState> {
  final AuthService _authService;

  RegisterCubit(this._authService) : super(RegisterInitialState());

  tryRegister(String name, String email, String password) async {
    emit(RegisterLoadingState());
    final _response = await _authService.register(name, email, password);
    if (_response is Exception) {
      emit(RegisterFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (!_isError) {
        emit(RegisterSuccessState());
      } else {
        emit(RegisterFailureState(_response['message']));
      }
    }
  }
}
