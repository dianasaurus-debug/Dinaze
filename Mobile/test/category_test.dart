import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/display_category/display_category_cubit.dart';
import 'package:flutter_cash_waqf/services/category_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryService extends Mock implements CategoryService {}

void main() {
  late final MockCategoryService mockCategoryService;

  setUpAll(() {
    mockCategoryService = MockCategoryService();
  });

  setUp(() {
    reset(mockCategoryService);
  });

  blocTest<DisplayCategoryCubit, DisplayCategoryState>(
    "Success",
    build: () {
      when(() => mockCategoryService.getAll())
          .thenAnswer((_) async => Future.value({
                "error": false,
                "message": "Berhasil menampilan semua kategori",
                "data": [
                  {
                    "id": 1,
                    "nama": "Pendidikan",
                    "deskripsi": "Deskripsi program wakaf pendidikan",
                    "gambar": "1624109808127anak-sd.jpg",
                    "ikon_flutter": "FontAwesomeIcons.graduationCap",
                    "created_at": "2021-06-15T15:23:28.000Z",
                    "updated_at": "2021-06-19T13:36:48.000Z"
                  },
                  {
                    "id": 2,
                    "nama": "Kesehatan",
                    "deskripsi": "Deskripsi program wakaf kesehatan",
                    "gambar": "1624251731112anak-sd.jpg",
                    "ikon_flutter": "FontAwesomeIcons.hospital",
                    "created_at": "2021-06-15T15:23:28.000Z",
                    "updated_at": "2021-06-21T05:02:11.000Z"
                  }
                ]
              }));
      return DisplayCategoryCubit(mockCategoryService);
    },
    act: (bloc) async => await bloc.getAll(),
    expect: () => [
      isA<DisplayCategoryLoadingState>(),
      isA<DisplayCategorySuccessState>(),
    ],
  );

  blocTest<DisplayCategoryCubit, DisplayCategoryState>(
    "Empty",
    build: () {
      when(() => mockCategoryService.getAll())
          .thenAnswer((_) async => Future.value({
                "error": true,
                "message": "Data kategori kosong",
              }));
      return DisplayCategoryCubit(mockCategoryService);
    },
    act: (bloc) async => await bloc.getAll(),
    expect: () => [
      isA<DisplayCategoryLoadingState>(),
      isA<DisplayCategoryFailureState>(),
    ],
  );

  blocTest<DisplayCategoryCubit, DisplayCategoryState>(
    "Exception",
    build: () {
      when(() => mockCategoryService.getAll())
          .thenAnswer((_) async => Exception());
      return DisplayCategoryCubit(mockCategoryService);
    },
    act: (bloc) async => await bloc.getAll(),
    expect: () => [
      isA<DisplayCategoryLoadingState>(),
      isA<DisplayCategoryFailureState>(),
    ],
  );
}
