import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/riwayat_wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf.dart';
import 'package:flutter_cash_waqf/services/riwayat_wakaf_service.dart';

abstract class GetWakifState {}

class GetWakifInitialState extends GetWakifState {}

class GetWakifLoadingState extends GetWakifState {}

class GetWakifFailureState extends GetWakifState {
  final String message;

  GetWakifFailureState(this.message);
}

class GetWakifEmptyState extends GetWakifState {
  final String message;

  GetWakifEmptyState(this.message);
}

class GetWakifSuccessState extends GetWakifState {
  final List<Wakaf> listWakaf;

  GetWakifSuccessState(this.listWakaf);
}

class GetWakifCubit extends Cubit<GetWakifState> {
  final RiwayatWakafService _service = RiwayatWakafService();

  GetWakifCubit() : super(GetWakifInitialState());

  void resetState() => emit(GetWakifInitialState());

  get(int id) async {
    emit(GetWakifLoadingState());
    final _response = await _service.getByProgram(id);
    if (_response is Exception) {
      emit(GetWakifFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        (_response['empty'])
            ? emit(GetWakifEmptyState(_response['message']))
            : emit(GetWakifFailureState(_response['message']));
      } else {
        emit(GetWakifSuccessState(
            RiwayatWakaf.createListWithoutProgram(_response['data'])));
      }
    }
  }

  refresh(int id) async {
    final _response = await _service.getByProgram(id);
    if (_response is Exception) {
      emit(GetWakifFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        (_response['empty'])
            ? emit(GetWakifEmptyState(_response['message']))
            : emit(GetWakifFailureState(_response['message']));
      } else {
        emit(GetWakifSuccessState(
            RiwayatWakaf.createListWithoutProgram(_response['data'])));
      }
    }
  }
}
