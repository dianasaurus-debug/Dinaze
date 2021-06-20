import 'package:bloc/bloc.dart';
import 'package:flutter_cash_waqf/model/kategori.dart';
import 'package:flutter_cash_waqf/services/category_service.dart';

abstract class DisplayCategoryState {}

class DisplayCategoryInitialState extends DisplayCategoryState {}

class DisplayCategoryLoadingState extends DisplayCategoryState {}

class DisplayCategoryFailureState extends DisplayCategoryState {
  final String message;

  DisplayCategoryFailureState(this.message);
}

class DisplayCategoryEmptyState extends DisplayCategoryState {}

class DisplayCategorySuccessState extends DisplayCategoryState {
  final List<Kategori> listKategori;

  DisplayCategorySuccessState(this.listKategori);
}

class DisplayCategoryCubit extends Cubit<DisplayCategoryState> {
  final CategoryService _categoryService = CategoryService();

  DisplayCategoryCubit() : super(DisplayCategoryInitialState());

  resetState() => emit(DisplayCategoryInitialState());

  getAll() async {
    emit(DisplayCategoryLoadingState());
    final _response = await _categoryService.getAll();
    print("RESPONSE: $_response");
    if (_response is Exception) {
      emit(DisplayCategoryFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(DisplayCategoryFailureState(_response['message']))
          : emit(DisplayCategorySuccessState(
              Kategori.createList(_response['data'])));
    }
  }

  refresh() async {
    final _response = await _categoryService.getAll();
    if (_response is Exception) {
      emit(DisplayCategoryFailureState(_response.toString()));
    } else {
      (_response['error'])
          ? emit(DisplayCategoryFailureState(_response['message']))
          : emit(DisplayCategorySuccessState(
              Kategori.createList(_response['data'])));
    }
  }
}
