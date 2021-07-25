import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/single_waqf_program/single_waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_program/waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/services/waqf_program_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWaqfProgramService extends Mock implements WaqfProgramService {}

main() {
  late final MockWaqfProgramService mockWaqfProgramService;

  setUpAll(() {
    mockWaqfProgramService = MockWaqfProgramService();
  });

  setUp(() {
    reset(mockWaqfProgramService);
  });

  group("Get All", () {
    blocTest<WaqfProgramCubit, WaqfProgramState>(
      "Success",
      build: () {
        when(() => mockWaqfProgramService.getAll())
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil menampilkan semua program wakaf",
                  "data": [
                    {
                      "id": 1,
                      "kategori_id": 4,
                      "judul": "Gerakan Nasional Wakaf Uang (GNWU)",
                      "deskripsi":
                          "Gerakan nasional untuk menghimpun wakaf uang untuk kesejahteraan bangsa Indonesia di bidang kesehatan, pendidikan, dan ekonomi kemasyarakatan bersama.",
                      "gambar": "gerakan-nasional-wakaf-uang.webp",
                      "created_at": "2021-06-15T15:23:28.000Z",
                      "updated_at": "2021-06-21T05:01:27.000Z",
                      "wakaf_abadi_terkumpul": 101530000,
                      "wakaf_berjangka_terkumpul": 100000000,
                      "kategori": {
                        "id": 4,
                        "nama": "Umum",
                        "deskripsi": "Deskripsi program wakaf umum",
                        "gambar": "1624112042965086251600_1615495412-Aji_1.jpg",
                        "ikon_flutter": "FontAwesomeIcons.handsHelping",
                        "created_at": "2021-06-15T15:23:28.000Z",
                        "updated_at": "2021-06-19T14:14:02.000Z"
                      }
                    },
                  ]
                }));
        return WaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getAll(),
      expect: () => [
        isA<WaqfProgramLoadingState>(),
        isA<WaqfProgramFilledState>(),
      ],
    );

    blocTest<WaqfProgramCubit, WaqfProgramState>(
      "Failure",
      build: () {
        when(() => mockWaqfProgramService.getAll())
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Data program wakaf kosong",
                }));
        return WaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getAll(),
      expect: () => [
        isA<WaqfProgramLoadingState>(),
        isA<WaqfProgramFailureState>(),
      ],
    );

    blocTest<WaqfProgramCubit, WaqfProgramState>(
      "Exception",
      build: () {
        when(() => mockWaqfProgramService.getAll())
            .thenAnswer((_) async => Exception());
        return WaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getAll(),
      expect: () => [
        isA<WaqfProgramLoadingState>(),
        isA<WaqfProgramFailureState>(),
      ],
    );
  });

  group("Get Single", () {
    blocTest<SingleWaqfProgramCubit, SingleWaqfProgramState>(
      "Success",
      build: () {
        when(() => mockWaqfProgramService.getSingle(any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil menampilkan program wakaf",
                  "data": {
                    "id": 1,
                    "kategori_id": 4,
                    "judul": "Gerakan Nasional Wakaf Uang (GNWU)",
                    "deskripsi":
                        "Gerakan nasional untuk menghimpun wakaf uang untuk kesejahteraan bangsa Indonesia di bidang kesehatan, pendidikan, dan ekonomi kemasyarakatan.",
                    "gambar": "gerakan-nasional-wakaf-uang.webp",
                    "created_at": "2021-04-02T01:47:19.000Z",
                    "updated_at": "2021-04-02T01:47:19.000Z",
                    "wakaf_abadi_terkumpul": 0,
                    "wakaf_berjangka_terkumpul": 0,
                    "kategori": {
                      "id": 4,
                      "nama": "Umum",
                      "deskripsi": "Deskripsi program wakaf umum",
                      "gambar": "umum.png",
                      "ikon_flutter": "Icons.umum",
                      "created_at": "2021-04-02T01:47:19.000Z",
                      "updated_at": "2021-04-02T01:47:19.000Z"
                    }
                  }
                }));
        return SingleWaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getSingle(0),
      expect: () => [
        isA<SingleWaqfProgramLoadingState>(),
        isA<SingleWaqfProgramSuccessState>(),
      ],
    );

    blocTest<SingleWaqfProgramCubit, SingleWaqfProgramState>(
      "Not Found",
      build: () {
        when(() => mockWaqfProgramService.getSingle(any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Program wakaf tidak ditemukan",
                }));
        return SingleWaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getSingle(0),
      expect: () => [
        isA<SingleWaqfProgramLoadingState>(),
        isA<SingleWaqfProgramFailureState>(),
      ],
    );

    blocTest<SingleWaqfProgramCubit, SingleWaqfProgramState>(
      "Exception",
      build: () {
        when(() => mockWaqfProgramService.getSingle(any()))
            .thenAnswer((_) async => Exception());
        return SingleWaqfProgramCubit(mockWaqfProgramService);
      },
      act: (bloc) async => await bloc.getSingle(0),
      expect: () => [
        isA<SingleWaqfProgramLoadingState>(),
        isA<SingleWaqfProgramFailureState>(),
      ],
    );
  });
}
