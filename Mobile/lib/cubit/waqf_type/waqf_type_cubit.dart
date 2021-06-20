import 'package:bloc/bloc.dart';

abstract class WaqfTypeState {}

class WaqfTypeInitialState extends WaqfTypeState {}

class TimelessWaqfTypeState extends WaqfTypeState {}

class TimedWaqfTypeState extends WaqfTypeState {}

class WaqfTypeCubit extends Cubit<WaqfTypeState> {
  WaqfTypeCubit() : super(WaqfTypeInitialState());

  void resetState() => emit(WaqfTypeInitialState());
  void selectTimelessWaqf() => emit(TimelessWaqfTypeState());
  void selectTimedWaqf() => emit(TimedWaqfTypeState());
}
