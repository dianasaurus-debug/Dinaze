import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/services/wakaf_berjangka_service.dart';

abstract class CreateWakafBerjangkaState {}

class CreateWakafBerjangkaInitialState extends CreateWakafBerjangkaState {}

class CreateWakafBerjangkaLoadingState extends CreateWakafBerjangkaState {}

class CreateWakafBerjangkaFailureState extends CreateWakafBerjangkaState {
  final String message;

  CreateWakafBerjangkaFailureState(this.message);
}

class CreateWakafBerjangkaSuccessState extends CreateWakafBerjangkaState {
  final WakafBerjangka wakafBerjangka;

  CreateWakafBerjangkaSuccessState(this.wakafBerjangka);
}

class CreateWakafBerjangkaCubit extends Cubit<CreateWakafBerjangkaState> {
  final WakafBerjangkaService _wakafBerjangkaService;

  CreateWakafBerjangkaCubit(this._wakafBerjangkaService)
      : super(CreateWakafBerjangkaInitialState());

  void resetState() => emit(CreateWakafBerjangkaInitialState());

  Future<void> create(WakafBerjangka wakafBerjangka) async {
    emit(CreateWakafBerjangkaLoadingState());
    final _response = await _wakafBerjangkaService.create(wakafBerjangka);
    print(_response);
    if (_response is Exception) {
      emit(CreateWakafBerjangkaFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (!_isError) {
        emit(CreateWakafBerjangkaSuccessState(
            WakafBerjangka.createFromJson(_response['data'])));
      } else {
        emit(CreateWakafBerjangkaFailureState(_response['message']));
      }
    }
  }
}
