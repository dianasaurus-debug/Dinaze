import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';

class WakafAbadi extends Wakaf {
  String? id;
  int? programWakafId;
  int? wakifId;
  int? nominal;
  String? namaWakif;
  String? jenisPembayaran;
  String? metodePembayaran;
  String? kodePembayaran;
  String? statusPembayaran;
  String? aktaIkrarWakaf;
  String? sertifikatWakafUang;
  String? tanggal;
  String? waktu;
  ProgramWakaf? programWakaf;

  WakafAbadi({
    this.id,
    this.programWakafId,
    this.wakifId,
    this.nominal,
    this.namaWakif,
    this.jenisPembayaran,
    this.metodePembayaran,
    this.kodePembayaran,
    this.statusPembayaran,
    this.aktaIkrarWakaf,
    this.sertifikatWakafUang,
    this.tanggal,
    this.waktu,
    this.programWakaf,
  });

  factory WakafAbadi.createFromJson(Map<String, dynamic> data) => WakafAbadi(
        id: data['id'],
        nominal: data['nominal'],
        namaWakif: data['nama_wakif'],
        metodePembayaran: data['metode_pembayaran'],
        kodePembayaran: data['kode_pembayaran'],
        statusPembayaran: data['status_pembayaran'],
        aktaIkrarWakaf: (data['nama_file_akta'] != null)
            ? "${Constant.aiwUrlApi}/${data['nama_file_akta']}"
            : null,
        sertifikatWakafUang: (data['nama_file_sertifikat'] != null)
            ? "${Constant.swuUrlApi}/${data['nama_file_sertifikat']}"
            : null,
        tanggal: data['tanggal'],
        waktu: data['waktu'],
        programWakaf: ProgramWakaf.createWithoutKategori(data['program_wakaf']),
      );

  factory WakafAbadi.createWithoutProgram(Map<String, dynamic> data) =>
      WakafAbadi(
        id: data['id'],
        nominal: data['nominal'],
        namaWakif: data['nama_wakif'],
        metodePembayaran: data['metode_pembayaran'],
        kodePembayaran: data['kode_pembayaran'],
        statusPembayaran: data['status_pembayaran'],
        tanggal: data['tanggal'],
        waktu: data['waktu'],
      );
}
