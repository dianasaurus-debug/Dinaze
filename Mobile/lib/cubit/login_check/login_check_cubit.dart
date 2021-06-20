import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

abstract class LoginCheckState {}

class LoginCheckInitial extends LoginCheckState {}

class LoggedInState extends LoginCheckState {}

class NotLoggedInState extends LoginCheckState {}

class TokenExpiredState extends LoginCheckState {}

class LoginCheckCubit extends Cubit<LoginCheckState> {
  final _storage = FlutterSecureStorage();

  LoginCheckCubit() : super(LoginCheckInitial());

  void loginCheck() async {
    final String? _token = await _storage.read(key: 'token');
    if (_token != null) {
      if (JwtDecoder.isExpired(_token.substring(7))) {
        await _storage.deleteAll();
        emit(TokenExpiredState());
      } else {
        emit(LoggedInState());
      }
    } else {
      emit(NotLoggedInState());
    }
  }
}
