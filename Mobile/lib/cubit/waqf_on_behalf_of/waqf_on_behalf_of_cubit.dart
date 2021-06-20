import 'package:bloc/bloc.dart';

abstract class WaqfOnBehalfOfState {}

class WaqfOnBehalfOfInitialState extends WaqfOnBehalfOfState {}

class WaqfOnBehalfOfOwnState extends WaqfOnBehalfOfState {}

class WaqfOnBehalfOfOtherState extends WaqfOnBehalfOfState {}

class WaqfOnBehalfOfCubit extends Cubit<WaqfOnBehalfOfState> {
  WaqfOnBehalfOfCubit() : super(WaqfOnBehalfOfInitialState());

  void selectOnBehalfOfOwn() => emit(WaqfOnBehalfOfOwnState());
  void selectOnBehalfOfOther() => emit(WaqfOnBehalfOfOtherState());
  void resetState() => emit(WaqfOnBehalfOfInitialState());
}
