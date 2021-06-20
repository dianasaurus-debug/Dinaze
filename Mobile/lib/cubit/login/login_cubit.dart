import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakif.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState(this.message);
}

class LoginSuccessState extends LoginState {
  final Wakif wakif;

  LoginSuccessState(this.wakif);
}

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  LoginCubit(this._authService) : super(LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    final _response = await _authService.login(email, password);
    if (_response is Exception) {
      emit(LoginFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        emit(LoginFailureState(_response['message']));
      } else {
        emit(LoginSuccessState(Wakif.create(_response['data'])));
        _saveUser(_response['data']['nama'], _response['accessToken']);
      }
    }
  }

  void _saveUser(String name, String token) async {
    await _storage.write(key: 'name', value: name);
    await _storage.write(key: 'token', value: token);
  }
}
