class Kategori {
  int? id;
  String? nama;
  String? deskripsi;
  String? gambar;
  String? ikonFlutter;

  Kategori({
    this.id,
    this.nama,
    this.deskripsi,
    this.gambar,
    this.ikonFlutter,
  });

  factory Kategori.createFromJson(Map<String, dynamic> data) => Kategori(
        id: data['id'],
        nama: data['nama'],
        deskripsi: data['deskripsi'],
        gambar: data['gambar'],
        ikonFlutter: data['ikonFlutter'],
      );

  static List<Kategori> createList(List<dynamic> data) => data
      .map<Kategori>((kategori) => Kategori(
            id: kategori['id'],
            nama: kategori['nama'],
            deskripsi: kategori['deskripsi'],
            gambar: kategori['gambar'],
            ikonFlutter: kategori['ikon_flutter'],
          ))
      .toList();
}
