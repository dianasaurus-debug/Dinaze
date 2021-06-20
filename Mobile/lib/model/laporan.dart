class Laporan {
  int? id;
  String? deskripsi;
  String? gambar;
  String? tanggal;
  String? waktu;

  Laporan({
    this.id,
    this.deskripsi,
    this.gambar,
    this.tanggal,
    this.waktu,
  });

  static List<Laporan> createList(List<dynamic> data) => data
      .map<Laporan>((laporan) => Laporan(
            id: laporan['id'],
            deskripsi: laporan['deskripsi'],
            gambar: laporan['gambar'],
            tanggal: laporan['tanggal'],
            waktu: laporan['waktu'],
          ))
      .toList();
}
