import 'package:flutter_cash_waqf/model/kategori.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';

class ProgramWakaf {
  int? id;
  String? judul;
  String? deskripsi;
  String? gambar;
  Kategori? kategori;
  int? wakafAbadiTerkumpul;
  int? wakafBerjangkaTerkumpul;

  ProgramWakaf({
    this.id,
    this.judul,
    this.deskripsi,
    this.gambar,
    this.kategori,
    this.wakafAbadiTerkumpul,
    this.wakafBerjangkaTerkumpul,
  });

  factory ProgramWakaf.createFromJson(Map<String, dynamic> data) =>
      ProgramWakaf(
        id: data['id'],
        judul: data['judul'],
        deskripsi: data['deskripsi'],
        gambar: "${Constant.imageUrlApi}/${data['gambar']}",
        kategori: Kategori.createFromJson(data['kategori']),
        wakafAbadiTerkumpul: data['wakaf_abadi_terkumpul'],
        wakafBerjangkaTerkumpul: data['wakaf_berjangka_terkumpul'],
      );

  factory ProgramWakaf.createWithoutKategori(Map<String, dynamic> data) =>
      ProgramWakaf(
        id: data['id'],
        judul: data['judul'],
        deskripsi: data['deskripsi'],
        gambar: "${Constant.imageUrlApi}/${data['gambar']}",
        wakafAbadiTerkumpul: data['wakaf_abadi_terkumpul'],
        wakafBerjangkaTerkumpul: data['wakaf_berjangka_terkumpul'],
      );

  static List<ProgramWakaf> createList(List<dynamic> data) => data
      .map<ProgramWakaf>((programWakaf) => ProgramWakaf(
            id: programWakaf['id'],
            judul: programWakaf['judul'],
            deskripsi: programWakaf['deskripsi'],
            gambar: "${Constant.imageUrlApi}/${programWakaf['gambar']}",
            kategori: Kategori.createFromJson(programWakaf['kategori']),
            wakafAbadiTerkumpul: programWakaf['wakaf_abadi_terkumpul'],
            wakafBerjangkaTerkumpul: programWakaf['wakaf_berjangka_terkumpul'],
          ))
      .toList();
}
