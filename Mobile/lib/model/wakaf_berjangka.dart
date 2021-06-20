import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';

class WakafBerjangka extends Wakaf {
  String? id;
  int? programWakafId;
  int? wakifId;
  int? nominal;
  String? namaWakif;
  String? jenisPembayaran;
  String? metodePembayaran;
  String? kodePembayaran;
  String? statusPembayaran;
  int? jangkaWaktu;
  String? jatuhTempo;
  String? namaBank;
  String? nomorRekening;
  String? namaPemilikRekening;
  String? statusPengembalian;
  String? aktaIkrarWakaf;
  String? sertifikatWakafUang;
  String? tanggal;
  String? waktu;
  ProgramWakaf? programWakaf;

  WakafBerjangka({
    this.id,
    this.programWakafId,
    this.wakifId,
    this.nominal,
    this.namaWakif,
    this.jenisPembayaran,
    this.metodePembayaran,
    this.kodePembayaran,
    this.statusPembayaran,
    this.jangkaWaktu,
    this.jatuhTempo,
    this.namaBank,
    this.nomorRekening,
    this.namaPemilikRekening,
    this.statusPengembalian,
    this.aktaIkrarWakaf,
    this.sertifikatWakafUang,
    this.tanggal,
    this.waktu,
    this.programWakaf,
  });

  factory WakafBerjangka.createFromJson(Map<String, dynamic> data) =>
      WakafBerjangka(
        id: data['id'],
        nominal: data['nominal'],
        namaWakif: data['nama_wakif'],
        metodePembayaran: data['metode_pembayaran'],
        kodePembayaran: data['kode_pembayaran'],
        statusPembayaran: data['status_pembayaran'],
        jangkaWaktu: data['jangka_waktu'],
        jatuhTempo: data['jatuh_tempo'],
        namaBank: data['nama_bank'],
        nomorRekening: data['nomor_rekening'],
        namaPemilikRekening: data['nama_pemilik_rekening'],
        statusPengembalian: data['status_pengembalian'],
        aktaIkrarWakaf: (data['nama_file_akta'] != null)
            ? "$aiwUrlApi/${data['nama_file_akta']}"
            : null,
        sertifikatWakafUang: (data['nama_file_sertifikat'] != null)
            ? "$swuUrlApi/${data['nama_file_sertifikat']}"
            : null,
        tanggal: data['tanggal'],
        waktu: data['waktu'],
        programWakaf: ProgramWakaf.createWithoutKategori(data['program_wakaf']),
      );

  factory WakafBerjangka.createWithoutProgram(Map<String, dynamic> data) =>
      WakafBerjangka(
        id: data['id'],
        nominal: data['nominal'],
        namaWakif: data['nama_wakif'],
        metodePembayaran: data['metode_pembayaran'],
        kodePembayaran: data['kode_pembayaran'],
        statusPembayaran: data['status_pembayaran'],
        jangkaWaktu: data['jangka_waktu'],
        jatuhTempo: data['jatuh_tempo'],
        namaBank: data['nama_bank'],
        nomorRekening: data['nomor_rekening'],
        namaPemilikRekening: data['nama_pemilik_rekening'],
        statusPengembalian: data['status_pengembalian'],
        tanggal: data['tanggal'],
        waktu: data['waktu'],
      );
}
