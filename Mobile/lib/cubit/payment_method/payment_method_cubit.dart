import 'package:bloc/bloc.dart';

abstract class PaymentMethodState {}

class PaymentMethodInitialState extends PaymentMethodState {}

class PaymentMethodSelectedState extends PaymentMethodState {
  final String type;
  final String code;

  PaymentMethodSelectedState(this.type, this.code);
}

class PaymentMethodCubit extends Cubit<PaymentMethodState> {
  PaymentMethodCubit() : super(PaymentMethodInitialState());

  void select(String type, String code) =>
      emit(PaymentMethodSelectedState(type, code));

  void resetState() => emit(PaymentMethodInitialState());
}
