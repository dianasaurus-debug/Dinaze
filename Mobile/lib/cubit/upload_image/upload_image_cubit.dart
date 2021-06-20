import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';

abstract class UploadImageState {}

class UploadImageInitialState extends UploadImageState {}

class UploadImageLoadingState extends UploadImageState {}

class UploadImageFailureState extends UploadImageState {
  final String message;

  UploadImageFailureState(this.message);
}

class UploadImageSuccessState extends UploadImageState {}

class UploadImageCubit extends Cubit<UploadImageState> {
  final _service = AuthService();

  UploadImageCubit() : super(UploadImageInitialState());

  upload(String path) async {
    emit(UploadImageLoadingState());
    final _response = await _service.uploadImage(path);
    if (_response is Exception) {
      emit(UploadImageFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(UploadImageFailureState(_response['message']))
          : emit(UploadImageSuccessState());
    }
  }
}
