import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/laporan.dart';
import 'package:flutter_cash_waqf/services/laporan_service.dart';

abstract class GetLaporanState {}

class GetLaporanInitialState extends GetLaporanState {}

class GetLaporanLoadingState extends GetLaporanState {}

class GetLaporanFailureState extends GetLaporanState {
  final String message;

  GetLaporanFailureState(this.message);
}

class GetLaporanEmptyState extends GetLaporanState {
  final String message;

  GetLaporanEmptyState(this.message);
}

class GetLaporanSuccessState extends GetLaporanState {
  final List<Laporan> listLaporan;

  GetLaporanSuccessState(this.listLaporan);
}

class GetLaporanCubit extends Cubit<GetLaporanState> {
  final _service = LaporanService();

  GetLaporanCubit() : super(GetLaporanInitialState());

  get(int id) async {
    emit(GetLaporanLoadingState());
    final _response = await _service.getByProgram(id);
    if (_response is Exception) {
      emit(GetLaporanFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        (_response['empty'])
            ? emit(GetLaporanEmptyState(_response['message']))
            : emit(GetLaporanFailureState(_response['message']));
      } else {
        emit(GetLaporanSuccessState(Laporan.createList(_response['data'])));
      }
    }
  }

  refresh(int id) async {
    final _response = await _service.getByProgram(id);
    if (_response is Exception) {
      emit(GetLaporanFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        (_response['empty'])
            ? emit(GetLaporanEmptyState(_response['message']))
            : emit(GetLaporanFailureState(_response['message']));
      } else {
        emit(GetLaporanSuccessState(Laporan.createList(_response['data'])));
      }
    }
  }
}
