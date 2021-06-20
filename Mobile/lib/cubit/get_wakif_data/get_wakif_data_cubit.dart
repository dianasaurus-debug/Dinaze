import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakif.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class GetWakifDataState {}

class GetWakifDataInitialState extends GetWakifDataState {}

class GetWakifDataLoadingState extends GetWakifDataState {}

class GetWakifDataFailureState extends GetWakifDataState {
  final String message;

  GetWakifDataFailureState(this.message);
}

class GetWakifDataSuccessState extends GetWakifDataState {
  final Wakif wakif;

  GetWakifDataSuccessState(this.wakif);
}

class GetWakifDataCubit extends Cubit<GetWakifDataState> {
  final AuthService _service = AuthService();

  GetWakifDataCubit() : super(GetWakifDataInitialState());

  get() async {
    emit(GetWakifDataLoadingState());
    final _response = await _service.getWakifData();
    if (_response is Exception) {
      emit(GetWakifDataFailureState(_response.toString()));
    } else {
      final bool _isError = _response['error'];
      (_isError)
          ? emit(GetWakifDataFailureState(_response['message']))
          : emit(GetWakifDataSuccessState(Wakif.create(_response['data'])));
    }
  }
}
