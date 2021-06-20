import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/riwayat_wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf.dart';
import 'package:flutter_cash_waqf/services/riwayat_wakaf_service.dart';

abstract class RiwayatWakafState {}

class RiwayatWakafInitialState extends RiwayatWakafState {}

class RiwayatWakafLoadingState extends RiwayatWakafState {}

class RiwayatWakafFailureState extends RiwayatWakafState {
  final String message;

  RiwayatWakafFailureState(this.message);
}

class RiwayatWakafEmptyState extends RiwayatWakafState {
  final String message;

  RiwayatWakafEmptyState(this.message);
}

class RiwayatWakafSuccessState extends RiwayatWakafState {
  final List<Wakaf> listRiwayatWakaf;

  RiwayatWakafSuccessState(this.listRiwayatWakaf);
}

class RiwayatWakafCubit extends Cubit<RiwayatWakafState> {
  final RiwayatWakafService _service = RiwayatWakafService();
  RiwayatWakafCubit() : super(RiwayatWakafInitialState());

  void resetState() => emit(RiwayatWakafInitialState());

  Future<void> getAll() async {
    emit(RiwayatWakafLoadingState());
    final _response = await _service.getAll();
    if (_response is Exception) {
      emit(RiwayatWakafFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (_isError) {
        final _isEmpty = _response['empty'];
        if (_isEmpty) {
          emit(RiwayatWakafEmptyState(_response['message']));
        } else {
          emit(RiwayatWakafFailureState(_response['message']));
        }
      } else {
        emit(RiwayatWakafSuccessState(
            RiwayatWakaf.createList(_response['data'])));
      }
    }
  }

  Future<void> getAllRefresh() async {
    final _response = await _service.getAll();
    if (_response is Exception) {
      emit(RiwayatWakafFailureState(_response.toString()));
    } else {
      final _isError = _response['error'];
      if (_isError) {
        final _isEmpty = _response['empty'];
        if (_isEmpty) {
          emit(RiwayatWakafEmptyState(_response['message']));
        } else {
          emit(RiwayatWakafFailureState(_response['message']));
        }
      } else {
        emit(RiwayatWakafSuccessState(
            RiwayatWakaf.createList(_response['data'])));
      }
    }
  }
}
