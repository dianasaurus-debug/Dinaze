import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/services/wakaf_abadi_service.dart';

abstract class GetWakafAbadiState {}

class GetWakafAbadiInitialState extends GetWakafAbadiState {}

class GetWakafAbadiLoadingState extends GetWakafAbadiState {}

class GetWakafAbadiFailureState extends GetWakafAbadiState {
  final String message;

  GetWakafAbadiFailureState(this.message);
}

class GetWakafAbadiSuccessState extends GetWakafAbadiState {
  final WakafAbadi wakafAbadi;

  GetWakafAbadiSuccessState(this.wakafAbadi);
}

class GetWakafAbadiCubit extends Cubit<GetWakafAbadiState> {
  final WakafAbadiService _wakafAbadiService;

  GetWakafAbadiCubit(this._wakafAbadiService)
      : super(GetWakafAbadiInitialState());

  void resetState() => emit(GetWakafAbadiInitialState());

  get(String id) async {
    emit(GetWakafAbadiLoadingState());
    final _response = await _wakafAbadiService.getById(id);
    if (_response is Exception) {
      emit(GetWakafAbadiFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (_isError) {
        emit(GetWakafAbadiFailureState(_response['message']));
      } else {
        emit(GetWakafAbadiSuccessState(
            WakafAbadi.createFromJson(_response['data'])));
      }
    }
  }

  refresh(String id) async {
    final _response = await _wakafAbadiService.getById(id);
    if (_response is Exception) {
      emit(GetWakafAbadiFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (_isError) {
        emit(GetWakafAbadiFailureState(_response['message']));
      } else {
        emit(GetWakafAbadiSuccessState(
            WakafAbadi.createFromJson(_response['data'])));
      }
    }
  }
}
