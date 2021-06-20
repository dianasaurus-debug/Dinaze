import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/services/waqf_program_service.dart';

abstract class WaqfProgramState {}

class WaqfProgramInitialState extends WaqfProgramState {}

class WaqfProgramLoadingState extends WaqfProgramState {}

class WaqfProgramFailureState extends WaqfProgramState {
  final String message;

  WaqfProgramFailureState(this.message);
}

class WaqfProgramEmptyState extends WaqfProgramState {}

class WaqfProgramFilledState extends WaqfProgramState {
  final List<ProgramWakaf> listProgramWakaf;

  WaqfProgramFilledState(this.listProgramWakaf);
}

class WaqfProgramCubit extends Cubit<WaqfProgramState> {
  final WaqfProgramService _waqfProgramSerice = WaqfProgramService();
  WaqfProgramCubit() : super(WaqfProgramInitialState());

  getAll() async {
    emit(WaqfProgramLoadingState());
    final _response = await _waqfProgramSerice.getAll();
    print("RESPONSE: $_response");
    if (_response is Exception) {
      emit(WaqfProgramFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(WaqfProgramFailureState(_response['message']))
          : emit(WaqfProgramFilledState(
              ProgramWakaf.createList(_response['data'])));
    }
  }

  refresh() async {
    final _response = await _waqfProgramSerice.getAll();
    if (_response is Exception) {
      emit(WaqfProgramFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(WaqfProgramFailureState(_response['message']))
          : emit(WaqfProgramFilledState(
              ProgramWakaf.createList(_response['data'])));
    }
  }
}
