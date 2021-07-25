import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_abadi/create_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakaf_abadi/get_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/services/wakaf_abadi_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWakafAbadiService extends Mock implements WakafAbadiService {}

class FakeWakafAbadi extends Fake implements WakafAbadi {}

main() {
  late final MockWakafAbadiService _mockWakafAbadiService;

  setUpAll(() {
    _mockWakafAbadiService = MockWakafAbadiService();
    registerFallbackValue(FakeWakafAbadi());
  });

  setUp(() {
    reset(_mockWakafAbadiService);
  });

  group("Create", () {
    blocTest<CreateWakafAbadiCubit, CreateWakafAbadiState>(
      "Success",
      build: () {
        when(() => _mockWakafAbadiService.create(any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil membuat transaksi wakaf abadi",
                  "data": {
                    "tanggal": "Jumat, 2 Juli 2021",
                    "waktu": "10:52",
                    "jenis": "Abadi",
                    "id": "490064cb-63fd-4346-9d62-3b12902a7844",
                    "program_wakaf_id": 2,
                    "wakif_id": 1,
                    "nominal": 100000,
                    "nama_wakif": "Praditya",
                    "metode_pembayaran": "bni",
                    "kode_pembayaran": "9882562607793215",
                    "status_pembayaran": "pending",
                    "nama_file_sertifikat": null,
                    "nama_file_akta": null,
                    "created_at": "2021-07-02T03:52:40.000Z",
                    "updated_at": "2021-07-02T03:52:41.097Z",
                    "program_wakaf": {
                      "id": 2,
                      "kategori_id": 4,
                      "judul": "ASN Kemenag Berwakaf",
                      "deskripsi":
                          "Program wakaf aparatur sipil negara (ASN) Kementerian Agama Republik Indonesia dengan penyaluran manfaat untuk pemberian beasiswa pendidikan dan aktivasi pemanfaatan aset wakaf produktif.",
                      "gambar": "asn-kemenag-berwakaf.webp",
                      "created_at": "2021-06-15T15:23:28.000Z",
                      "updated_at": "2021-06-15T15:23:28.000Z"
                    }
                  }
                }));
        return CreateWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.create(FakeWakafAbadi()),
      expect: () => [
        isA<CreateWakafAbadiLoadingState>(),
        isA<CreateWakafAbadiSuccessState>(),
      ],
    );

    blocTest<CreateWakafAbadiCubit, CreateWakafAbadiState>(
      "Failure",
      build: () {
        when(() => _mockWakafAbadiService.create(any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Gagal membuat transaksi wakaf abadi",
                }));
        return CreateWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.create(FakeWakafAbadi()),
      expect: () => [
        isA<CreateWakafAbadiLoadingState>(),
        isA<CreateWakafAbadiFailureState>(),
      ],
    );

    blocTest<CreateWakafAbadiCubit, CreateWakafAbadiState>(
      "Exception",
      build: () {
        when(() => _mockWakafAbadiService.create(any()))
            .thenAnswer((_) async => Exception());
        return CreateWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.create(FakeWakafAbadi()),
      expect: () => [
        isA<CreateWakafAbadiLoadingState>(),
        isA<CreateWakafAbadiFailureState>(),
      ],
    );
  });

  group("Get Single", () {
    blocTest<GetWakafAbadiCubit, GetWakafAbadiState>(
      "Success",
      build: () {
        when(() => _mockWakafAbadiService.getById(any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil menampilkan data wakaf abadi",
                  "data": {
                    "tanggal": "Minggu, 28 Maret 2021",
                    "jenis": "Abadi",
                    "id": "d6194479-c9a2-440a-9b65-69fc0f1a386c",
                    "program_wakaf_id": 5,
                    "wakif_id": 1,
                    "nominal": 250000,
                    "nama_wakif": "Praditya Nafiis Muhammad",
                    "metode_pembayaran": "alfamart",
                    "kode_pembayaran": "1256151649802875",
                    "status_pembayaran": "failure",
                    "created_at": "2021-03-28T15:00:17.000Z",
                    "updated_at": "2021-03-29T15:00:31.000Z",
                    "program_wakaf": {
                      "id": 5,
                      "kategori_id": 1,
                      "judul": "Kalisa - Institut Pertanian Bogor",
                      "deskripsi":
                          "Pembangunan retina center Rumah Sakit Mata Achmad Wardi di Kota Serang (Provinsi Banten).",
                      "gambar": "kalisa-institut-pertanian-bogor.webp",
                      "created_at": "2021-03-23T04:23:31.000Z",
                      "updated_at": "2021-03-23T04:23:31.000Z"
                    }
                  }
                }));
        return GetWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafAbadiLoadingState>(),
        isA<GetWakafAbadiSuccessState>(),
      ],
    );

    blocTest<GetWakafAbadiCubit, GetWakafAbadiState>(
      "Failure",
      build: () {
        when(() => _mockWakafAbadiService.getById(any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Data wakaf abadi tidak ditemukan",
                }));
        return GetWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafAbadiLoadingState>(),
        isA<GetWakafAbadiFailureState>(),
      ],
    );

    blocTest<GetWakafAbadiCubit, GetWakafAbadiState>(
      "Exception",
      build: () {
        when(() => _mockWakafAbadiService.getById(any()))
            .thenAnswer((_) async => Exception());
        return GetWakafAbadiCubit(_mockWakafAbadiService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafAbadiLoadingState>(),
        isA<GetWakafAbadiFailureState>(),
      ],
    );
  });
}
