import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/wakif.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class UpdateWakifDataState {}

class UpdateWakifDataInitialState extends UpdateWakifDataState {}

class UpdateWakifDataLoadingState extends UpdateWakifDataState {}

class UpdateWakifDataFailureState extends UpdateWakifDataState {
  final String message;

  UpdateWakifDataFailureState(this.message);
}

class UpdateWakifDataSuccessState extends UpdateWakifDataState {}

class UpdateWakifDataCubit extends Cubit<UpdateWakifDataState> {
  final AuthService _service = AuthService();

  UpdateWakifDataCubit() : super(UpdateWakifDataInitialState());

  update(Wakif wakif) async {
    emit(UpdateWakifDataLoadingState());
    final _response = await _service.updateWakifData(wakif);
    if (_response is Exception) {
      return UpdateWakifDataFailureState(_response.toString());
    } else {
      (_response['error'])
          ? emit(UpdateWakifDataFailureState(_response['message']))
          : emit(UpdateWakifDataSuccessState());
    }
  }
}
