import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/services/waqf_program_service.dart';

abstract class WaqfProgramByCategoryState {}

class WaqfProgramByCategoryInitialState extends WaqfProgramByCategoryState {}

class WaqfProgramByCategoryLoadingState extends WaqfProgramByCategoryState {}

class WaqfProgramByCategoryFailureState extends WaqfProgramByCategoryState {
  final String message;

  WaqfProgramByCategoryFailureState(this.message);
}

class WaqfProgramByCategoryEmptyState extends WaqfProgramByCategoryState {
  final String message;

  WaqfProgramByCategoryEmptyState(this.message);
}

class WaqfProgramByCategorySuccessState extends WaqfProgramByCategoryState {
  final List<ProgramWakaf> listProgramWakaf;

  WaqfProgramByCategorySuccessState(this.listProgramWakaf);
}

class WaqfProgramByCategoryCubit extends Cubit<WaqfProgramByCategoryState> {
  final WaqfProgramService _waqfProgramSerice = WaqfProgramService();
  WaqfProgramByCategoryCubit() : super(WaqfProgramByCategoryInitialState());

  get(int id) async {
    emit(WaqfProgramByCategoryLoadingState());
    final _response = await _waqfProgramSerice.getByCategory(id);
    if (_response is Exception) {
      emit(WaqfProgramByCategoryFailureState(_response.toString()));
    } else {
      final bool _isError = _response['error'];
      if (_isError) {
        final bool _isEmpty = _response['empty'];
        if (_isEmpty) {
          emit(WaqfProgramByCategoryEmptyState(_response['message']));
        } else {
          emit(WaqfProgramByCategoryFailureState(_response['message']));
        }
      } else {
        emit(WaqfProgramByCategorySuccessState(
            ProgramWakaf.createList(_response['data'])));
      }
    }
  }
}
