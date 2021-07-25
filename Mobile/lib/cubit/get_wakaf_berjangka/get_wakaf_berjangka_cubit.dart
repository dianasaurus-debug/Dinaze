import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/services/wakaf_berjangka_service.dart';

abstract class GetWakafBerjangkaState {}

class GetWakafBerjangkaInitialState extends GetWakafBerjangkaState {}

class GetWakafBerjangkaLoadingState extends GetWakafBerjangkaState {}

class GetWakafBerjangkaFailureState extends GetWakafBerjangkaState {
  final String message;

  GetWakafBerjangkaFailureState(this.message);
}

class GetWakafBerjangkaSuccessState extends GetWakafBerjangkaState {
  final WakafBerjangka wakafBerjangka;

  GetWakafBerjangkaSuccessState(this.wakafBerjangka);
}

class GetWakafBerjangkaCubit extends Cubit<GetWakafBerjangkaState> {
  final WakafBerjangkaService _service;

  GetWakafBerjangkaCubit(this._service)
      : super(GetWakafBerjangkaInitialState());

  void resetState() => emit(GetWakafBerjangkaInitialState());

  get(String id) async {
    emit(GetWakafBerjangkaLoadingState());
    final _response = await _service.getById(id);
    if (_response is Exception) {
      emit(GetWakafBerjangkaFailureState(_response.toString()));
    } else {
      final bool _isError = _response['error'];
      if (_isError) {
        emit(GetWakafBerjangkaFailureState(_response['message']));
      } else {
        emit(GetWakafBerjangkaSuccessState(
            WakafBerjangka.createFromJson(_response['data'])));
      }
    }
  }

  refresh(String id) async {
    final _response = await _service.getById(id);
    if (_response is Exception) {
      emit(GetWakafBerjangkaFailureState(_response.toString()));
    } else {
      final bool _isError = _response['error'];
      if (_isError) {
        emit(GetWakafBerjangkaFailureState(_response['message']));
      } else {
        emit(GetWakafBerjangkaSuccessState(
            WakafBerjangka.createFromJson(_response['data'])));
      }
    }
  }
}
