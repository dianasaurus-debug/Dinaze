import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_berjangka/create_wakaf_berjangka_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakaf_berjangka/get_wakaf_berjangka_cubit.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/services/wakaf_berjangka_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWakafBerjangkaService extends Mock implements WakafBerjangkaService {}

class FakeWakafBerjangka extends Fake implements WakafBerjangka {}

main() {
  late final MockWakafBerjangkaService _mockWakafBerjangkaService;

  setUpAll(() {
    _mockWakafBerjangkaService = MockWakafBerjangkaService();
    registerFallbackValue(FakeWakafBerjangka());
  });

  setUp(() {
    reset(_mockWakafBerjangkaService);
  });

  group("Create", () {
    blocTest<CreateWakafBerjangkaCubit, CreateWakafBerjangkaState>(
      "Success",
      build: () {
        when(() => _mockWakafBerjangkaService.create(any()))
            .thenAnswer((_) => Future.value({
                  "error": false,
                  "message": "Berhasil membuat transaksi wakaf berjangka",
                  "data": {
                    "jatuh_tempo": "Minggu, 10 April 2022",
                    "tanggal": "Sabtu, 10 April 2021",
                    "jenis": "Berjangka",
                    "id": "b83941d2-bcf3-4edf-97ea-d7849d6bd07f",
                    "program_wakaf_id": 2,
                    "wakif_id": 1,
                    "nominal": 100000,
                    "nama_wakif": "Praditya",
                    "metode_pembayaran": "bca",
                    "kode_pembayaran": "125626545045",
                    "status_pembayaran": "pending",
                    "jangka_waktu": 1,
                    "nama_bank": "Bank Mandiri",
                    "nomor_rekening": "9000021957544",
                    "nama_pemilik_rekening": "Praditya Nafiis Muhammad",
                    "status_pengembalian": "pending",
                    "created_at": "2021-04-10T05:08:12.000Z",
                    "updated_at": "2021-04-10T05:08:12.924Z",
                    "program_wakaf": {
                      "id": 2,
                      "kategori_id": 4,
                      "judul": "ASN Kemenag Berwakaf",
                      "deskripsi":
                          "Program wakaf aparatur sipil negara (ASN) Kementerian Agama Republik Indonesia dengan penyaluran manfaat untuk pemberian beasiswa pendidikan dan aktivasi pemanfaatan aset wakaf produktif.",
                      "gambar": "asn-kemenag-berwakaf.webp",
                      "created_at": "2021-04-10T04:39:56.000Z",
                      "updated_at": "2021-04-10T04:39:56.000Z"
                    }
                  }
                }));
        return CreateWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.create(FakeWakafBerjangka()),
      expect: () => [
        isA<CreateWakafBerjangkaLoadingState>(),
        isA<CreateWakafBerjangkaSuccessState>(),
      ],
    );

    blocTest<CreateWakafBerjangkaCubit, CreateWakafBerjangkaState>(
      "Failure",
      build: () {
        when(() => _mockWakafBerjangkaService.create(any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Gagal membuat transaksi wakaf berjangka",
                }));
        return CreateWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.create(FakeWakafBerjangka()),
      expect: () => [
        isA<CreateWakafBerjangkaLoadingState>(),
        isA<CreateWakafBerjangkaFailureState>(),
      ],
    );

    blocTest<CreateWakafBerjangkaCubit, CreateWakafBerjangkaState>(
      "Exception",
      build: () {
        when(() => _mockWakafBerjangkaService.create(any()))
            .thenAnswer((_) async => Exception());
        return CreateWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.create(FakeWakafBerjangka()),
      expect: () => [
        isA<CreateWakafBerjangkaLoadingState>(),
        isA<CreateWakafBerjangkaFailureState>(),
      ],
    );
  });

  group("Get Single", () {
    blocTest<GetWakafBerjangkaCubit, GetWakafBerjangkaState>(
      "Failure",
      build: () {
        when(() => _mockWakafBerjangkaService.getById(any()))
            .thenAnswer((_) async => Future.value({
                  "error": false,
                  "message": "Berhasil menampilkan data wakaf berjangka",
                  "data": {
                    "jatuh_tempo": "Sabtu, 23 Juli 2022",
                    "tanggal": "Jumat, 23 Juli 2021",
                    "waktu": "22:06",
                    "jenis": "Berjangka",
                    "id": "5bf96fc2-5f93-410e-a0c3-d1b85e33a9c9",
                    "program_wakaf_id": 1,
                    "wakif_id": 1,
                    "nominal": 250000,
                    "nama_wakif": "Diana Fitri",
                    "metode_pembayaran": "bca",
                    "kode_pembayaran": "125626938225",
                    "status_pembayaran": "success",
                    "jangka_waktu": 1,
                    "nama_bank": "BCA",
                    "nomor_rekening": "1670765721",
                    "nama_pemilik_rekening": "Nafiis",
                    "status_pengembalian": "pending",
                    "nama_file_sertifikat": null,
                    "nama_file_akta": null,
                    "created_at": "2021-07-23T15:06:38.000Z",
                    "updated_at": "2021-07-23T15:08:03.000Z",
                    "wakif": {
                      "id": 1,
                      "google_id": "i9C66OZXLlbS1IQCycFkxWrpBFW2",
                      "nik": "3201010707000001",
                      "nama": "Praditya Nafiis",
                      "email": "pradityanafiis@gmail.com",
                      "password": "dsadad",
                      "nomor_ponsel": "082277771838",
                      "alamat": "Cibinong, Kabupaten Bogor",
                      "foto":
                          "Wakif_1627053041127_image_cropper_1627053025023.jpg",
                      "created_at": "2021-07-20T07:19:05.000Z",
                      "updated_at": "2021-07-23T15:12:15.000Z"
                    },
                    "program_wakaf": {
                      "id": 1,
                      "kategori_id": 4,
                      "judul": "Gerakan Nasional Wakaf Uang (GNWU)",
                      "deskripsi":
                          "Gerakan nasional untuk menghimpun wakaf uang untuk kesejahteraan bangsa Indonesia di bidang kesehatan, pendidikan, dan ekonomi kemasyarakatan.",
                      "gambar": "gerakan-nasional-wakaf-uang.webp",
                      "created_at": "2021-07-20T07:19:05.000Z",
                      "updated_at": "2021-07-20T07:19:05.000Z"
                    }
                  }
                }));
        return GetWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafBerjangkaLoadingState>(),
        isA<GetWakafBerjangkaSuccessState>(),
      ],
    );

    blocTest<GetWakafBerjangkaCubit, GetWakafBerjangkaState>(
      "Failure",
      build: () {
        when(() => _mockWakafBerjangkaService.getById(any()))
            .thenAnswer((_) async => Future.value({
                  "error": true,
                  "message": "Data wakaf berjangka tidak ditemukan",
                }));
        return GetWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafBerjangkaLoadingState>(),
        isA<GetWakafBerjangkaFailureState>(),
      ],
    );

    blocTest<GetWakafBerjangkaCubit, GetWakafBerjangkaState>(
      "Exception",
      build: () {
        when(() => _mockWakafBerjangkaService.getById(any()))
            .thenAnswer((_) async => Exception());
        return GetWakafBerjangkaCubit(_mockWakafBerjangkaService);
      },
      act: (bloc) async => await bloc.get("0"),
      expect: () => [
        isA<GetWakafBerjangkaLoadingState>(),
        isA<GetWakafBerjangkaFailureState>(),
      ],
    );
  });
}
