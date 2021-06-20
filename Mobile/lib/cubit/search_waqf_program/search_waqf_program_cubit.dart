import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/services/waqf_program_service.dart';

abstract class SearchWaqfProgramState {}

class SearchWaqfProgramInitialState extends SearchWaqfProgramState {}

class SearchWaqfProgramLoadingState extends SearchWaqfProgramState {}

class SearchWaqfProgramFailureState extends SearchWaqfProgramState {
  final String message;

  SearchWaqfProgramFailureState(this.message);
}

class SearchWaqfProgramEmptyState extends SearchWaqfProgramState {
  final String message;

  SearchWaqfProgramEmptyState(this.message);
}

class SearchWaqfProgramSuccessState extends SearchWaqfProgramState {
  final List<ProgramWakaf> listProgramWakaf;

  SearchWaqfProgramSuccessState(this.listProgramWakaf);
}

class SearchWaqfProgramCubit extends Cubit<SearchWaqfProgramState> {
  final WaqfProgramService _service = WaqfProgramService();

  SearchWaqfProgramCubit() : super(SearchWaqfProgramInitialState());

  resetState() => emit(SearchWaqfProgramInitialState());

  search(String query) async {
    emit(SearchWaqfProgramLoadingState());
    final _response = await _service.search(query);
    if (_response is Exception) {
      emit(SearchWaqfProgramFailureState(_response.toString()));
    } else {
      if (_response['error']) {
        if (_response['empty']) {
          emit(SearchWaqfProgramEmptyState(_response['message']));
        } else {
          emit(SearchWaqfProgramFailureState(_response['message']));
        }
      } else {
        emit(SearchWaqfProgramSuccessState(
            ProgramWakaf.createList(_response['data'])));
      }
    }
  }
}
