import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthState {}

class FirebaseAuthInitialState extends FirebaseAuthState {}

class FirebaseAuthLoadingState extends FirebaseAuthState {}

class FirebaseAuthFailureState extends FirebaseAuthState {
  final String message;

  FirebaseAuthFailureState(this.message);
}

class FirebaseAuthRegisteredState extends FirebaseAuthState {}

class FirebaseAuthNotRegisteredState extends FirebaseAuthState {}

class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  final _googleSignIn = GoogleSignIn();
  final _authService = AuthService();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  FirebaseAuthCubit() : super(FirebaseAuthInitialState());

  getUserData() async {
    emit(FirebaseAuthLoadingState());
    final _googleUser = await _googleSignIn.signIn();

    if (_googleUser == null) {
      emit(FirebaseAuthFailureState("Anda belum memilih akun Google"));
    } else {
      final googleAuth = await _googleUser.authentication;

      await FirebaseAuth.instance
          .signInWithCredential(GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      ));

      final _user = FirebaseAuth.instance.currentUser;

      if (_user != null) _checkStatus();
    }
  }

  _checkStatus() async {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      final _response = await _authService.firebaseCheck(_user.uid);
      if (_response is Exception) {
        emit(FirebaseAuthFailureState(_response.toString()));
      } else {
        if (_response['error']) {
          emit(FirebaseAuthNotRegisteredState());
        } else {
          emit(FirebaseAuthRegisteredState());
          _saveUser(_response['data']['nama'], _response['accessToken']);
          _dispose();
        }
      }
    }
  }

  register(String password) async {
    emit(FirebaseAuthLoadingState());
    final _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      final _response = await _authService.firebaseRegister(
          _user.displayName!, _user.email!, password, _user.uid);
      if (_response is Exception) {
        emit(FirebaseAuthFailureState(_response.toString()));
      } else {
        if (_response['error']) {
          emit(FirebaseAuthFailureState(_response['message']));
        } else {
          emit(FirebaseAuthRegisteredState());
          _saveUser(_response['data']['nama'], _response['accessToken']);
        }
      }
    }
    _dispose();
  }

  void _dispose() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  void _saveUser(String name, String token) async {
    await _storage.write(key: 'name', value: name);
    await _storage.write(key: 'token', value: token);
  }
}
