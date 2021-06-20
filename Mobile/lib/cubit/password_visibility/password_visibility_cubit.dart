import 'package:bloc/bloc.dart';

abstract class PasswordVisibilityState {}

class PasswordInvisibleState extends PasswordVisibilityState {}

class PasswordVisibleState extends PasswordVisibilityState {}

class PasswordVisibilityCubit extends Cubit<PasswordVisibilityState> {
  PasswordVisibilityCubit() : super(PasswordInvisibleState());

  void hidePassword() => emit(PasswordInvisibleState());

  void showPassword() => emit(PasswordVisibleState());
}
