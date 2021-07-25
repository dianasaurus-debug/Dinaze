import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/services/wakaf_abadi_service.dart';

class CreateWakafAbadiCubit extends Cubit<CreateWakafAbadiState> {
  final WakafAbadiService _wakafAbadiService;

  CreateWakafAbadiCubit(this._wakafAbadiService)
      : super(CreateWakafAbadiInitialState());

  void resetState() => emit(CreateWakafAbadiInitialState());

  Future<void> create(WakafAbadi wakafAbadi) async {
    emit(CreateWakafAbadiLoadingState());
    final _response = await _wakafAbadiService.create(wakafAbadi);
    if (_response is Exception) {
      emit(CreateWakafAbadiFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (!_isError) {
        emit(CreateWakafAbadiSuccessState(
            WakafAbadi.createFromJson(_response['data'])));
      } else {
        emit(CreateWakafAbadiFailureState(_response['message']));
      }
    }
  }
}

abstract class CreateWakafAbadiState {}

class CreateWakafAbadiInitialState extends CreateWakafAbadiState {}

class CreateWakafAbadiLoadingState extends CreateWakafAbadiState {}

class CreateWakafAbadiFailureState extends CreateWakafAbadiState {
  final String message;

  CreateWakafAbadiFailureState(this.message);
}

class CreateWakafAbadiSuccessState extends CreateWakafAbadiState {
  final WakafAbadi wakafAbadi;

  CreateWakafAbadiSuccessState(this.wakafAbadi);
}
