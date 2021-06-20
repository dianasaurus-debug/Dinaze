import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class ChangePasswordState {}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordFailureState extends ChangePasswordState {
  final String message;

  ChangePasswordFailureState(this.message);
}

class ChangePasswordSuccessState extends ChangePasswordState {}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthService _service = AuthService();

  ChangePasswordCubit() : super(ChangePasswordInitialState());

  change(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoadingState());
    final _response = await _service.changePassword(oldPassword, newPassword);
    if (_response is Exception) {
      emit(ChangePasswordFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(ChangePasswordFailureState(_response['message']))
          : emit(ChangePasswordSuccessState());
    }
  }
}
